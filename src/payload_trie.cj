/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj
from std import unicode.*

/*
 * The class is PayloadTrie
 * @since 0.38.2
 */
public class PayloadTrie<T> {
    
    private let trieConfig: TrieConfig
    private let rootState: PayloadState<T>

    protected init(trieConfig: TrieConfig) {
        this.trieConfig = trieConfig
        this.rootState = PayloadState<T>()
    }

    /**
     * Provides a fluent interface for constructing Trie instances with payloads.
     * @param <T> The type of the emitted payload.
     *
     * @return The builder used to configure its Trie.
     */
    public static func builder(): PayloadTrieBuilder<T> {
        return PayloadTrieBuilder<T>()
    }

    /**
     * Used by the builder to add a text search keyword.
     *
     * @param keyword The search term to add to the list of search terms.
     * @throws NullPointerException if the keyword is null.
     */
    protected func addKeyword(keyword: String): Unit {
        if (keyword.isEmpty()) {
            return
        }
        addState(keyword).addEmit(Payload<T>(keyword, None))
    }

    /**
     * Used by the builder to add a text search keyword with an emit payload.
     *
     * @param keyword The search term to add to the list of search terms.
     * @param emit    the payload to emit for this search term.
     * @throws NullPointerException if the keyword is null.
     */
    protected func addKeyword(keyword: String, emit: ?T): Unit {
        if (keyword.isEmpty()) {
            return
        }
        addState(keyword).addEmit(Payload<T>(keyword, emit))
    }

    private func addState(keyword: String): PayloadState<T> {
        var state: PayloadState<T> = getRootState()
        var adjustedChar: Char
        for (character in keyword.toCharArray()) {
            if (isCaseInsensitive()) {
                adjustedChar = character.toLowerCase()
            }
            adjustedChar = character
            state = state.addState(adjustedChar)
        }
        return state
    }

    private func getRootState(): PayloadState<T> {
        return this.rootState
    }

    private func isCaseInsensitive(): Bool {
        return trieConfig.isCaseInsensitive()
    }

    protected func constructFailureStates(): Unit {
        var arrayList: ArrayList<PayloadState<T>> = ArrayList<PayloadState<T>>()
        var startState: PayloadState<T> = getRootState()
        // First, set the fail state of all depth 1 states to the root state
        for (depthOneState in startState.getStates()) {
            depthOneState.setFailure(startState)
            arrayList.append(depthOneState)
        }
        // Second, determine the fail state for all depth > 1 state
        while (!arrayList.isEmpty()) {
            var currentState: PayloadState<T> = arrayList.remove(0)
            for (transition in currentState.getTransitions()) {
                var targetState: PayloadState<T> = currentState.nextState(transition).getOrThrow()
                arrayList.append(targetState)
                var traceFailureState: ?PayloadState<T> = currentState.failures()
                while (let None = traceFailureState.getOrThrow().nextState(transition)) {
                    traceFailureState = traceFailureState.getOrThrow().failures()
                }
                var newFailureState: PayloadState<T> = traceFailureState.getOrThrow().nextState(transition).getOrThrow()
                targetState.setFailure(newFailureState)
                targetState.addEmit(newFailureState.emit())
            }
        }
    }

    public func parseText(text: String): Collection<PayloadEmit<T>> {
        return parseText(text, DefaultPayloadEmitHandler<T>())
    }

    public func parseText(text: String, emitHandler: StatefulPayloadEmitHandler<T>): Collection<PayloadEmit<T>> {
        parseText(text, (emitHandler as PayloadEmitHandler<T>).getOrThrow())
        let collectedEmits: ArrayList<PayloadEmit<T>> = emitHandler.getEmits()
        if (!trieConfig.isAllowOverlaps()) {
            let collectedIntervalable: ArrayList<Intervalable> = match (collectedEmits as ArrayList<Intervalable>) {
                case Some(v) => v
                case None => ArrayList<Intervalable>()
            }
            let intervalTree: IntervalTree  = IntervalTree(collectedIntervalable)
            intervalTree.removeOverlaps(collectedIntervalable)
        }
        return collectedEmits
    }

    public func parseText(text: String, emitHandler: PayloadEmitHandler<T>): Unit {
        var currentState: PayloadState<T> = getRootState()
        var position = 0
        while (position < text.size) {
            var character: Char = text.charAt(position)
            if (trieConfig.isCaseInsensitive()) {
                character = character.toLowerCase()
            }
            currentState = getState(currentState, character)
            let payloads: Collection<Payload<T>> = currentState.emit()
            if (processEmits(text, Int32(position), payloads, emitHandler) && trieConfig.isStopOnHit()) {
                return
            }
            position ++
        }
    }

    private func processEmits(text: String, pos: Int32, payloads: Collection<Payload<T>>, emitHandler: PayloadEmitHandler<T>): Bool {
        var emitted: Bool = false
        for (payload in payloads) {
            let payloadEmit: PayloadEmit<T> = PayloadEmit<T>(pos - Int32(payload.getKeyword().size) + 1, pos, payload.getKeyword(), payload.getData())
            if (!(trieConfig.isOnlyWholeWords() && isPartialMatch(text, payloadEmit)) && !(trieConfig.isOnlyWholeWordsWhiteSpaceSeparated() && isPartialMatchWhiteSpaceSeparated(text, payloadEmit))) {
                emitted = emitHandler.emit(payloadEmit) || emitted
                if (emitted && trieConfig.isStopOnHit()) {
                    break
                }
            }
        }
        return emitted
    }

    private func isPartialMatch(searchText: String, emit: PayloadEmit<T>): Bool {
        return (emit.getStart() != 0 && (searchText.charAt(Int64(emit.getStart()) - 1)).isLetter()) ||
                (Int64(emit.getEnd()) + 1 != searchText.size && (searchText.charAt(Int64(emit.getEnd()) + 1)).isLetter())
    }

    private func isPartialMatchWhiteSpaceSeparated(searchText: String, emit: PayloadEmit<T>): Bool {
        let size: Int64 = searchText.size
        return (emit.getStart() != 0 && !(searchText.charAt(Int64(emit.getStart()) - 1)).isWhiteSpace()) ||
                (Int64(emit.getEnd()) + 1 != size && !(searchText.charAt(Int64(emit.getEnd()) + 1)).isWhiteSpace())
    }

    private func getState(currentState: PayloadState<T>, character: Char): PayloadState<T> {
        var newCurrentState: ?PayloadState<T> = currentState.nextState(character)
        while (let None = newCurrentState) {
            var current: PayloadState<T> = currentState
            current = current.failures().getOrThrow()
            newCurrentState = current.nextState(character)
        }
        return newCurrentState.getOrThrow()
    }
}

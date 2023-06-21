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
    
    protected let trieConfig: TrieConfig
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

    /**
     * Tokenizes the specified text and returns the emitted outputs.
     *
     * @param text The text to tokenize.
     * @return the emitted outputs
     */
    public func tokenize(text: String): Collection<PayloadToken<T>> {
        var tokens: ArrayList<PayloadToken<T>> = ArrayList<PayloadToken<T>>()
        let collectedEmits: Collection<PayloadEmit<T>> = parseText(text)
        var lastCollectedPosition: Int32 = -1

        for (emit in collectedEmits) {
            if (emit.getStart() - lastCollectedPosition > 1) {
                tokens.append( createFragment( emit, text, lastCollectedPosition) )
            }

            tokens.append(createMatch(emit, text))
            lastCollectedPosition = emit.getEnd()
        }

        if (Int32(text.size) - lastCollectedPosition > 1) {
            tokens.append( createFragment( None, text, lastCollectedPosition) )
        }

        return tokens
    }

    private func createFragment(emit: ?PayloadEmit<T>, text: String, lastCollectedPosition: Int32): PayloadToken<T> {
        if (let None = emit) {
            return PayloadFragmentToken<T>(text[Int64(lastCollectedPosition + 1)..text.size])
        } else {
            return PayloadFragmentToken<T>(text[Int64(lastCollectedPosition + 1)..Int64(emit.getOrThrow().getStart())])
        }
    }

    private func createMatch(emit: PayloadEmit<T>, text: String): PayloadToken<T> {
        return PayloadMatchToken<T>(text[Int64(emit.getStart())..Int64(emit.getEnd() + 1)], emit)
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
            let convertArr: ArrayList<Intervalable> = ArrayList<Intervalable>()
            for (col in collectedEmits) {
                convertArr.append(col)
            }
            let intervalTree: IntervalTree  = IntervalTree(convertArr)
            intervalTree.removeOverlaps(convertArr)
            let arr2: ArrayList<PayloadEmit<T>> = ArrayList<PayloadEmit<T>>()
            for (coll in convertArr) {
                arr2.append((coll as PayloadEmit<T>).getOrThrow())
            }
            return arr2
        }
        return collectedEmits
    }

    /**
     * Returns true if the text contains one of the search terms; otherwise,
     * returns false.
     *
     * @param text Specified text.
     * @return true if the text contains one of the search terms. Else, returns
     *         false.
     */
    public func containsMatch(text: String): Bool {
        if (let None = firstMatch(text)) {
            return false
        }
        return true
    }

    /**
     * The first matching text sequence.
     *
     * @param text The text to search for keywords, must not be {@code null}.
     * @return {@code null} if no matches found.
     */
    public func firstMatch(text: String): ?PayloadEmit<T> {
        if (!trieConfig.isAllowOverlaps()) {
            // Slow path. Needs to find all the matches to detect overlaps.
            let parseText: Collection<PayloadEmit<T>> = parseText(text)
            if (!parseText.isEmpty()) {
                return parseText.iterator().next()
            }
        } else {
            // Fast path. Returns first match found.
            var currentState: PayloadState<T> = getRootState()
            var position: Int64 = 0
            while (position < text.size) {
                var character: Char = text[position]
                if (trieConfig.isCaseInsensitive()) {
                    character = character.toLowerCase()
                }
                currentState = getState(currentState, character)
                let payloads: Collection<Payload<T>> = currentState.emit()
                let arrayList: ArrayList<Payload<T>> = ArrayList<Payload<T>>()
                for (payload in payloads) {
                    arrayList.append(payload)
                }
                arrayList.sortBy(compareTo, stable: true)
                if (!arrayList.isEmpty()) {
                    for (arr in arrayList) {
                        let emit: PayloadEmit<T> = PayloadEmit<T>(Int32(position - arr.getKeyword().size) + 1, Int32(position), arr.getKeyword(), arr.getData())
                            if (trieConfig.isOnlyWholeWords()) {
                                if (!isPartialMatch(text, emit)) {
                                    return emit
                                }
                            } else {
                                return emit
                            }
                    }
                }
                position++
            }
        }
        return None
    }

    private func compareTo(emit1: Payload<T>, emit2: Payload<T>): Ordering {
        var comparison = emit2.getKeyword().size - emit1.getKeyword().size
        if (comparison < 0) {
            return Ordering.GT
        } else if(comparison > 0) {
            return Ordering.LT
        } else {
            return Ordering.EQ
        }
    }

    public func parseText(text: String, emitHandler: PayloadEmitHandler<T>): Unit {
        var currentState: PayloadState<T> = getRootState()
        var position = 0
        while (position < text.size) {
            var character: Char = text[position]
            if (trieConfig.isCaseInsensitive()) {
                character = character.toLowerCase()
            }
            currentState = getState(currentState, character)
            let payloads: Collection<Payload<T>> = currentState.emit()
            if (processEmits(text, Int32(position), payloads, emitHandler) && trieConfig.isStopOnHit()) {
                return
            }
            position++
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
        return (emit.getStart() != 0 && (searchText[Int64(emit.getStart()) - 1]).isLetter()) ||
                (Int64(emit.getEnd()) + 1 != searchText.size && (searchText[Int64(emit.getEnd()) + 1]).isLetter())
    }

    private func isPartialMatchWhiteSpaceSeparated(searchText: String, emit: PayloadEmit<T>): Bool {
        let size: Int64 = searchText.size
        return (emit.getStart() != 0 && !(searchText[Int64(emit.getStart()) - 1]).isWhiteSpace()) ||
                (Int64(emit.getEnd()) + 1 != size && !(searchText[Int64(emit.getEnd()) + 1]).isWhiteSpace())
    }

    private func getState(currentState: PayloadState<T>, character: Char): PayloadState<T> {
        var newCurrentState: ?PayloadState<T> = currentState.nextState(character)
        var current: PayloadState<T> = currentState
        while (let None = newCurrentState) {
            current = current.failures().getOrThrow()
            newCurrentState = current.nextState(character)
        }
        return newCurrentState.getOrThrow()
    }
}

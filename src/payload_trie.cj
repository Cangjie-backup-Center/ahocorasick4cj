/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

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
     * Adds a keyword and a payload to the {@link Trie}'s list of text
     * search keywords.
     *
     * @param keyword The keyword to add to the list.
     * @param payload the payload to add
     * @return This builder.
     * @throws NullPointerException if the keyword is null.
     */
    public func addKeyword(keyword: String, payload: T): PayloadTrieBuilder<T> {
        return PayloadTrieBuilder<T>()
    }

    /**
     * Used by the builder to add a text search keyword with an emit payload.
     *
     * @param keyword The search term to add to the list of search terms.
     * @param emit    the payload to emit for this search term.
     * @throws NullPointerException if the keyword is null.
     */
    private func addKeyword_pri(keyword: String, emit: T): Unit {

    }

    private func addState(keyword: String): PayloadState<T> {
        return PayloadState<T>()
    }

    private func getRootState(): PayloadState<T> {
        return this.rootState
    }

    private func isCaseInsensitive(): Bool {
        return trieConfig.isCaseInsensitive()
    }

    protected func constructFailureStates(): Unit {

    }

    public func parseText(text: String): Collection<PayloadEmit<T>> {
        return ArrayList<PayloadEmit<T>>()
    }

    public func parseText(text: String, emitHandler: StatefulPayloadEmitHandler<T>): Collection<PayloadEmit<T>> {
        return ArrayList<PayloadEmit<T>>()
    }

    private func processEmits(text: String, position: Int32, payloads: Collection<Payload<T>>, emitHandler: PayloadEmitHandler<T>): Bool {
        return false
    }

    private func getState(currentState: PayloadState<T>, character: Char): PayloadState<T> {
        var current: PayloadState<T> = currentState
        var newCurrentState: ?PayloadState<T> = currentState.nextState(character)

        while (let None = newCurrentState) {
            current = currentState.failures()
            newCurrentState = currentState.nextState(character)
        }

        return newCurrentState.getOrThrow()
    }
}

/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is PayloadTrieBuilder
 * @since 0.38.2
 */
public class PayloadTrieBuilder<T> {
    
    private let trieConfig: TrieConfig = TrieConfig()
    private let trie: PayloadTrie<T> = PayloadTrie<T>(trieConfig)

    public func build(): PayloadTrie<T> {
        this.trie.constructFailureStates()
        return this.trie
    }

    /**
     * Adds a keyword to the {@link Trie}'s list of text search keywords.
     * No {@link Payload} is supplied.
     *
     * @param keyword The keyword to add to the list.
     * @return This builder.
     * @throws NullPointerException if the keyword is null.
     */
    public func addKeyword(keyword: String): PayloadTrieBuilder<T> {
        this.trie.addKeyword(keyword)
        return this
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
    public func addKeyword(keyword: String, payload: ?T): PayloadTrieBuilder<T> {
        this.trie.addKeyword(keyword, payload)
        return this
    }
}

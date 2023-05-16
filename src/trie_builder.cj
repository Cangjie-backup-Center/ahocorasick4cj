/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is TrieBuilder
 * @since 0.38.2
 */
public class TrieBuilder {
    
    private let delegate: PayloadTrieBuilder<String> = PayloadTrie.builder()
    
    /**
     * Default (empty) constructor.
     */
    protected init() {}

    /**
     * Adds a keyword to the Trie's list of text search keywords.
     *
     * @param keyword The keyword to add to the list.
     * @return This builder.
     * @throws NullPointerException if the keyword is null.
     */
    public func addKeyword(keyword: String): TrieBuilder {
        return TrieBuilder()
    }

    /**
     * Configure the Trie based on the builder settings.
     *
     * @return The configured Trie.
     */
    public func build(): Trie {
        var payloadTrie: PayloadTrie<String> = this.delegate.build()
        return Trie(payloadTrie)
    }
}

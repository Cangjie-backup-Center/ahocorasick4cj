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
}

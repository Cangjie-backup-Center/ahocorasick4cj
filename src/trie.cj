/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

from std import collection.*

/*
 * The class is TrieBuilder
 * @since 0.38.2
 */
public class Trie {

    private let payloadTrie: PayloadTrie<String>

    protected init(payloadTrie: PayloadTrie<String>) {
        this.payloadTrie = payloadTrie
    }

    /**
     * Provides a fluent interface for constructing Trie instances.
     *
     * @return The builder used to configure its Trie.
     */
    public static func builder(): TrieBuilder {
        return TrieBuilder()
    }

    public func parseText(text: String): Collection<Emit> {
        let parsedText: Collection<PayloadEmit<String>> = this.payloadTrie.parseText(text)
        return asEmits(parsedText)
    }

    private static func asEmits(emits: Collection<PayloadEmit<String>>): Collection<Emit> {
        var result: ArrayList<Emit> = ArrayList<Emit>()
        for (emit in emits) {
            result.append(asEmit(emit))
        }
        return result
    }

    private static func asEmit(payloadEmit: PayloadEmit<String>): Emit {
        return Emit(payloadEmit.getStart(), payloadEmit.getEnd(), payloadEmit.getKeyword())
    }
}

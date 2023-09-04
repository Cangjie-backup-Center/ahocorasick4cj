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

    public func tokenize(text: String): Collection<Token> {
        let tokens: Collection<PayloadToken<String>> = this.payloadTrie.tokenize(text)
        return asTokens(tokens)
    }

    private static func asTokens(tokens: Collection<PayloadToken<String>>): Collection<Token> {
        var result: ArrayList<Token> = ArrayList<Token>()
        for (payloadToken in tokens) {
            result.append(DefaultToken(payloadToken))
        }
        return result
    }

    private static func asEmits(emits: Collection<PayloadEmit<String>>): Collection<Emit> {
        var result: ArrayList<Emit> = ArrayList<Emit>()
        for (emit in emits) {
            result.append(asEmit(emit))
        }
        return result
    }

    private static func asEmit(payloadEmit: PayloadEmit<String>): Emit {
        return Emit(payloadEmit.start, payloadEmit.end, payloadEmit.keyword)
    }

    public func parseText(text: String): Collection<Emit> {
        let parsedText: Collection<PayloadEmit<String>> = this.payloadTrie.parseText(text)
        return asEmits(parsedText)
    }

    public func parseText(text: String, emitHandler: StatefulEmitHandler): Collection<Emit> {
        let parsedText: Collection<PayloadEmit<String>> = this.payloadTrie.parseText(text, StatefulPayloadEmitDelegateHandler(emitHandler))
        return asEmits(parsedText)
    }

    public func containsMatch(text: String): Bool {
        if (let None <- firstMatch(text)) {
            return false
        }
        return true
    }

    public func parseText(text: String, emitHandler: EmitHandler): Unit {
        this.payloadTrie.parseText(text, PayloadEmitDelegateHandler(emitHandler))
    }

    /**
     * The first matching text sequence.
     *
     * @param text The text to search for keywords, must not be {@code null}.
     * @return {@code null} if no matches found.
     */
    public func firstMatch(text: String): ?Emit {
        let payload: ?PayloadEmit<String> = this.payloadTrie.firstMatch(text)
        if (let None <- payload) {
            return None
        } else {
            return Emit(payload.getOrThrow().start, payload.getOrThrow().end, payload.getOrThrow().keyword)
        }
    }

    /**
     * Provides a fluent interface for constructing Trie instances.
     *
     * @return The builder used to configure its Trie.
     */
    public static func builder(): TrieBuilder {
        return TrieBuilder()
    }
}

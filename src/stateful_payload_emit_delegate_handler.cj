/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The interface is StatefulPayloadEmitDelegateHandler
 * @since 0.38.2
 */
public class StatefulPayloadEmitDelegateHandler <: StatefulPayloadEmitHandler<String> {

    private var handler: StatefulEmitHandler

    public init(handler: StatefulEmitHandler) {
        this.handler = handler
    }

    private static func asEmits(emits: Collection<Emit>): ArrayList<PayloadEmit<String>> {
        var result: ArrayList<PayloadEmit<String>> = ArrayList<PayloadEmit<String>>()
        for (emit in emits) {
            result.append(PayloadEmit<String>(emit.getStart(), emit.getEnd(), emit.getKeyword(), None))
        }
        return result
    }

    public func emit(emit: PayloadEmit<String>): Bool {
        let newEmit: Emit = Emit(emit.getStart(), emit.getEnd(), emit.getKeyword())
        return handler.emit(newEmit)
    }

    public func getEmits(): ArrayList<PayloadEmit<String>> {
        let emits: ArrayList<Emit> = this.handler.getEmits()
        return asEmits(emits)
    }

}

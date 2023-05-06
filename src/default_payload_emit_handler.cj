/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package ahoCorasick4cj

/*
 * The class is DefaultPayloadEmitHandler
 * @since 0.38.2
 */
public class DefaultPayloadEmitHandler<T> <: StatefulPayloadEmitHandler<T> {

    private let emits: ArrayList<PayloadEmit<T>> = ArrayList<PayloadEmit<T>>()

    public func emit(emit: PayloadEmit<T>): Bool {
        this.emits.append(emit)
        return true
    }

    public func getEmits(): ArrayList<PayloadEmit<T>> {
        return this.emits
    }
}

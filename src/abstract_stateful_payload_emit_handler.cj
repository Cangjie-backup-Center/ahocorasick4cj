/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package ahoCorasick4cj

/*
 * The class is AbstractStatefulPayloadEmitHandler
 * @since 0.38.2
 */
public abstract class AbstractStatefulPayloadEmitHandler<T> <: StatefulPayloadEmitHandler<T> {

    var emits: ArrayList<PayloadEmit<T>> = ArrayList<PayloadEmit<T>>()

    public func addEmit(emit: PayloadEmit<T>): Unit {
        this.emits.append(emit)
    }

    public func getEmits(): ArrayList<PayloadEmit<T>> {
        return this.emits
    }
}

/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package ahoCorasick4cj

/*
 * The class is AbstractStatefulEmitHandler
 * @since 0.38.2
 */
public abstract class AbstractStatefulEmitHandler<T> <: StatefulEmitHandler {

    var emits: ArrayList<Emit> = ArrayList<Emit>()

    public func addEmit(emit: Emit): Unit {
        this.emits.append(emit)
    }

    public func getEmits(): ArrayList<Emit> {
        return this.emits
    }
}

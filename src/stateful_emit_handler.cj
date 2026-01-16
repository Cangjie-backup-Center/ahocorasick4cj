/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
package cangjie_tpc::ahoCorasick4cj

/*
 * The interface is StatefulEmitHandler
 * @since 0.38.2
 */
public interface StatefulEmitHandler <: EmitHandler {
    func getEmits(): ArrayList<Emit>
}

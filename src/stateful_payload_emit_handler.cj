/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The interface is StatefulPayloadEmitHandler
 * @since 0.38.2
 */
public interface StatefulPayloadEmitHandler<T> {
    func getEmits(): ArrayList<PayloadEmit<T>>
}

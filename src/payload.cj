/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is Payload
 * @since 0.38.2
 */
public abstract class Payload<T> <: Comparable<Payload<T>> & Hashable & Equatable<T> {
    
    private let keyword: String
    private let data: T

    public init(keyword: String, data: T) {
        super()
        this.keyword = keyword
        this.data = data
    }

    public func getKeyword(): String {
        return keyword
    }

    public func getData(): T {
        return data
    }

    public func compareTo(other: Payload<T>): Ordering {
        return keyword.compare(other.getKeyword())
    }
}

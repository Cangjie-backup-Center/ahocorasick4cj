/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is PayloadEmit
 * @since 0.38.2
 */
public class PayloadEmit<T> <: Interval {

    private let keyword: String

    private let payload: T

    public init(start: Int32, end: Int32, keyword: String, payload: T) {
        super(start,end)
        this.keyword = keyword
        this.payload = payload
    }

    public func getKeyword(): String {
        return this.keyword
    }

    public func getPayload(): T {
        return this.payload
    }

    public func toString(): String {
        return super.toString() + "=" + this.keyword + "->"
    }
}

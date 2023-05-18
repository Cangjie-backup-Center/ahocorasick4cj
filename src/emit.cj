/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

from std import convert.*

/*
 * The class is Emit
 * @since 0.38.2
 */
public class Emit <: Interval & Intervalable {
    
    private let keyword: String

    public init(start: Int32, end: Int32, keyword: String) {
        super(start, end)
        this.keyword = keyword
    }

    public func getKeyword(): String {
        return this.keyword
    }

    public operator func ==(rhs: Intervalable): Bool {
        if (this.toString().equals(rhs.toString())) {
            return true
        }
        return false
    }

    public operator func !=(rhs: Intervalable): Bool {
        if (!this.toString().equals(rhs.toString())) {
            return true
        }
        return false
    }

    public func hashCode(): Int64 {
        var hash: Int64 = 0
        hash = 31 * hash + keyword.hashCode()
        return hash
    }

    public func toString(): String {
        return super.toString() + "=" + this.keyword
    }
}

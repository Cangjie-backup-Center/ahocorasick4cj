/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is Interval
 * @since 0.38.2
 */
public open class Interval <: Intervalable {

    private let start: Int32
    private let end: Int32

    /**
     * Constructs an interval with a start and end position.
     *
     * @param start The interval's starting text position.
     * @param end   The interval's ending text position.
     */
    public init(start: Int32, end: Int32) {
        this.start = start
        this.end = end
        if ((end - start) < 0) {
            throw Exception("The start length must be smaller than the end length")
        }
    }

    /**
     * Returns the starting offset into the text for this interval.
     *
     * @return A number between 0 (start of text) and the text length.
     */
    public func getStart(): Int32 {
        return this.start
    }

    /**
     * Returns the ending offset into the text for this interval.
     *
     * @return A number between getStart() + 1 and the text length.
     */
    public func getEnd(): Int32 {
        return this.end
    }

    /**
     * Returns the length of the interval.
     *
     * @return The end position less the start position, plus one.
     */
    public func size(): Int32 {
        return end - start + 1
    }

    /**
     * Returns the starting offset and ending offset separated
     * by a full colon (:).
     *
     * @return A non-null String, never empty.
     */
    public open func toString(): String {
        return this.start.toString() + ":" + this.end.toString()
    }

    public open operator func ==(rhs: Intervalable): Bool {
        if (this.toString().equals(rhs.toString())) {
            return true
        }
        return false
    }

    public open operator func !=(rhs: Intervalable): Bool {
        if (!this.toString().equals(rhs.toString())) {
            return true
        }
        return false
    }

    public open func hashCode(): Int64 {
        var hash: Int64 = 0
        hash = 31 * hash + Int64(start)
        hash = 31 * hash + Int64(end)
        return hash
    }
}

/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is IntervalTree
 * @since 0.38.2
 */
public class IntervalTree {

    private let rootNode: IntervalNode

    public init(intervals: ArrayList<Intervalable>) {
        this.rootNode = IntervalNode.newInstance(intervals)
    }

    public func removeOverlaps(intervals: ArrayList<Intervalable>): ArrayList<Intervalable> {
        return ArrayList<Intervalable>()
    }
}

/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is IntervalNode
 * @since 0.38.2
 */
public class IntervalNode {

    var left: IntervalNode = IntervalNode()
    var right: IntervalNode = IntervalNode()
    var point: Int32 = 0
    var intervals: ArrayList<Intervalable> = ArrayList<Intervalable>()

    private init() {}

    public static func newInstance(intervals: ArrayList<Intervalable>): IntervalNode {
        let node: IntervalNode = IntervalNode()
        node.point = determineMedian(intervals)

        let toLeft: ArrayList<Intervalable> = ArrayList<Intervalable>()
        let toRight: ArrayList<Intervalable> = ArrayList<Intervalable>()

        for (interval in intervals) {
            if (interval.getEnd() < node.point) {
                toLeft.append(interval)
            } else if (interval.getStart() > node.point) {
                toRight.append(interval)
            } else {
                node.intervals.append(interval)
            }
        }

        if (!toLeft.isEmpty()) {
            node.left = IntervalNode.newInstance(toLeft)
        }

        if (!toRight.isEmpty()) {
            node.right = IntervalNode.newInstance(toRight)
        }

        return node
    }

    public static func determineMedian(intervals: ArrayList<Intervalable>): Int32 {
        var start: Int32 = -1
        var end: Int32 = -1
        for (interval in intervals) {
            var currentStart: Int32 = interval.getStart()
            var currentEnd: Int32 = interval.getEnd()
            if (start == -1 || currentStart < start) {
                start = currentStart
            }
            if (end == -1 || currentEnd > end) {
                end = currentEnd
            }
        }
        return (start + end) / 2
    }

}

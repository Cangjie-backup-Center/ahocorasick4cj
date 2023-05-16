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
        intervals.sortBy(compareSize, stable: true)
        var removeIntervals: Set<Intervalable> = HashSet<Intervalable>()
        for (interval in intervals) {
            // If the interval was already removed, ignore it
            if (removeIntervals.contains(interval)) {
                continue
            }
            // Remove all overallping intervals
            removeIntervals.putAll(findOverlaps(interval))
        }

        // Remove all intervals that were overlapping
        for (removeInterval in removeIntervals) {
            intervals.removeIf({removeInterval: Intervalable => return true})
        }
        intervals.sortBy(comparePosition, stable: true)
        return intervals
    }

    public func findOverlaps(interval: Intervalable): ArrayList<Intervalable> {
        return rootNode.findOverlaps(interval)
    }

    private func compareSize(intervalable: Intervalable, intervalable2: Intervalable): Ordering {
        var comparison = intervalable.size() - intervalable2.size()
        if (comparison > 0) {
            return Ordering.GT
        } else if(comparison < 0) {
            return Ordering.LT
        } else {
            return Ordering.EQ
        }
    }

    private func comparePosition(intervalable: Intervalable, intervalable2: Intervalable): Ordering {
        if (intervalable.getStart() > intervalable2.getStart()) {
            return Ordering.GT
        } else if(intervalable.getStart() < intervalable2.getStart()) {
            return Ordering.LT
        } else {
            return Ordering.EQ
        }
    }
}

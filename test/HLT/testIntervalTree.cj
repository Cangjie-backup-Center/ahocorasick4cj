// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj
// 3rd_party_lib_ohos:ahocorasick4cj/build/aarch64-linux-ohos/ahoCorasick4cj

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*

@Test
public class AhoCorasickTest {
  var int32Res:Int32 = -1
  var boolRes:Bool = false
  var returnFlag:Int64 =  -1

  @TestCase
  func testIntervalTree_01():Unit{ 
    // public init(intervals: ArrayList<Intervalable>)
    let intervalTree_1: IntervalTree = IntervalTree(ArrayList<Intervalable>())
    // public func removeOverlaps(intervals: ArrayList<Intervalable>): ArrayList<Intervalable>
    let resArrL_1:ArrayList<Intervalable> = intervalTree_1.removeOverlaps(ArrayList<Intervalable>())
    @Assert(resArrL_1.size,0)

    let emit_1: Emit = Emit(0, 0, "emit_1")
    let emit_2: Emit = Emit(-3, 0, "emit_2")
    let intervalableArrL:ArrayList<Intervalable> = ArrayList<Intervalable>([emit_1,emit_2])
    let resArrL_2:ArrayList<Intervalable> = intervalTree_1.removeOverlaps(intervalableArrL)
    @Assert(resArrL_2.size,2)
    let resArrL_3:ArrayList<Intervalable> = intervalTree_1.findOverlaps(emit_1)
    @Assert(resArrL_3.size,0)

  }

  @TestCase
  func testIntervalTree_02():Unit{ 
    let emit_1: PayloadEmit<String> = PayloadEmit<String>(0,0,"emit_1",None)
    let emit_2: PayloadEmit<String> = PayloadEmit<String>(-2,0,"emit_2","None")
    let emit_3: PayloadEmit<String> = PayloadEmit<String>(3,8,"emit_3","%仓颉%")
    let intervalableArrL1:ArrayList<Intervalable> = ArrayList<Intervalable>([emit_1,emit_2,emit_3])
    let intervalableArrL2:ArrayList<Intervalable> = ArrayList<Intervalable>([emit_1,emit_2])
    let intervalTree_1: IntervalTree = IntervalTree(intervalableArrL1)
    // public func removeOverlaps(intervals: ArrayList<Intervalable>): ArrayList<Intervalable>
    let resArrL_1:ArrayList<Intervalable> = intervalTree_1.removeOverlaps(intervalableArrL2)
    @Assert(resArrL_1.size,0)
    let resArrL_2:ArrayList<Intervalable> = intervalTree_1.removeOverlaps(ArrayList<Intervalable>())
    @Assert(resArrL_2.size,0)

    // public func findOverlaps(interval: Intervalable): ArrayList<Intervalable>
    let resArrL_3:ArrayList<Intervalable> = intervalTree_1.findOverlaps(emit_2)
    // println("int32Res_1:> ${resArrL_3.size}")
    @Assert(resArrL_3.size,2)

  }




}

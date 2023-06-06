// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*

@Test
public class AhoCorasickTest {
  var strRes:String =""
  var intRes:Int64 = -1
  var int32Res:Int32 = -1
  var returnFlag:Int64 =  -1

  @TestCase
  func testPayload_01():Unit{ 
    var str1:String = "^%#$#@#"
    // public init(keyword: String, data: ?T)
    let payload_1: Payload<String> = Payload(str1, Option<String>.None)
    // public func getKeyword(): String
    strRes = payload_1.getKeyword()
    @Assert(strRes, "^%#$#@#")
    // public func getData(): ?T
    @Assert(payload_1.getData(),Option<String>.None)
    @Assert(payload_1.hashCode(),545161237)
    let payload_2: Payload<String> = Payload(str1, None)
    @Assert(payload_2.hashCode(),payload_1.hashCode())
    @Assert(payload_2 == payload_1 ,true)
    @Assert(payload_2 != payload_1 ,false)
    // public func compare(other: Payload<T>): Ordering
    @Assert(payload_2.compare(payload_1) == EQ ,true)
    @Assert(payload_2.compare(payload_1).toString() ,"Ordering.EQ")

  }

  @TestCase
  func testPayload_02():Unit{ 
    var str1:String = "你好"
    let payload_1: Payload<String> = Payload(str1, Option<String>.None)
    strRes = payload_1.getKeyword()
    @Assert(strRes, "你好")
    // public func getData(): ?T
    @Assert(payload_1.getData(),None)
    str1 = ""
    let payload_2: Payload<String> = Payload(str1, Option<String>.None)
    @Assert(payload_2.getKeyword(),"")
    str1 = """
            cangjie
            test
          """
    let payload_3: Payload<String> = Payload(str1, str1)
    @Assert(payload_3 == payload_1 ,false)
    @Assert(payload_3.getData().getOrThrow().replace("\n","").replace(" ",""), "cangjietest")
    @Assert(payload_2.compare(payload_1).toString() ,"Ordering.LT")
    @Assert(payload_3.compare(payload_2) == GT ,true)

  }

}


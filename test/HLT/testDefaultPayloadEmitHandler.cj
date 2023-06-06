// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*

/* 
public func emit(emit: PayloadEmit<T>): Bool
public func getEmits(): ArrayList<PayloadEmit<T>>
 */

@Test
public class AhoCorasickTest {
  var strRes:String =""
  var boolRes:Bool = false
  var returnFlag:Int64 =  -1

  @TestCase
  func testDefaultPayloadEmitHandler_01():Unit{ 
    var defaultPayloadEmitHandler_1: DefaultPayloadEmitHandler<String> = DefaultPayloadEmitHandler<String>()
    var payload_1: Payload<String> = Payload<String>("Payload",Option<String>.Some("strData"))
    // public init(start: Int32, end: Int32, keyword: String, payload: ?T)
    var emit_1: PayloadEmit<String> = PayloadEmit<String>(0,0,"CangjieTest",None)
    // public func emit(emit: PayloadEmit<T>): Bool
    boolRes = defaultPayloadEmitHandler_1.emit(emit_1)
    @Assert(boolRes, true)
    var arrL = defaultPayloadEmitHandler_1.getEmits() // ArrayList<PayloadEmit<String>>
    @Assert(arrL.size, 1)

  }

  @TestCase
  func testDefaultPayloadEmitHandler_02():Unit{ 
    var defaultPayloadEmitHandler_1: DefaultPayloadEmitHandler<String> = DefaultPayloadEmitHandler<String>()
    var payload_1: Option<String> = Option<String>.Some("strData")
    var emit_2: PayloadEmit<String> = PayloadEmit<String>(0,0,"CangjieTest",payload_1)
    boolRes = defaultPayloadEmitHandler_1.emit(emit_2)
    @Assert(boolRes, true)
    var payloadEmitArrL = defaultPayloadEmitHandler_1.getEmits() // ArrayList<PayloadEmit<String>>
    // println("payloadEmitArrL_1:> ${payloadEmitArrL.size}")
    @Assert(payloadEmitArrL.size, 1)
    strRes = payloadEmitArrL[0].toString() // 0:0=CangjieTest->
    @Assert(strRes, "0:0=CangjieTest->")

  }

  @TestCase
  func testDefaultPayloadEmitHandler_03():Unit{ 
    returnFlag = -1
    var defaultPayloadEmitHandler_1: DefaultPayloadEmitHandler<String> = DefaultPayloadEmitHandler<String>()
    var payload_1: Option<String> = Option<String>.Some("strData")
    try {
      var emit_2: PayloadEmit<String> = PayloadEmit<String>(2,0,"CangjieTest",payload_1)
      boolRes = defaultPayloadEmitHandler_1.emit(emit_2)
    }catch (e1:Exception) {
      @Assert(e1.toString().contains("The start length must be smaller than the end length"), true)
      returnFlag = 0
    }

    @Assert(returnFlag, 0)
  }

  @TestCase
  func testDefaultPayloadEmitHandler_04():Unit{ 
    var defaultPayloadEmitHandler_1: DefaultPayloadEmitHandler<String> = DefaultPayloadEmitHandler<String>()
    var payload_1: Option<String> = Option<String>.Some("strData")
    var emit_2: PayloadEmit<String> = PayloadEmit<String>(-8,-1,"CangjieTest",payload_1)
    boolRes = defaultPayloadEmitHandler_1.emit(emit_2)
    @Assert(boolRes, true)
    var payloadEmitArrL = defaultPayloadEmitHandler_1.getEmits() // ArrayList<PayloadEmit<String>>
    @Assert(payloadEmitArrL.size, 1)

  }

}


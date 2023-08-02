// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj
// 3rd_party_lib_ohos:ahocorasick4cj/build/aarch64-linux-ohos/ahoCorasick4cj

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*
from std import math.MathExtension

@Test
public class AhoCorasickTest {
  var strRes:String =""
  var intRes:Int64 = -1
  var int32Res:Int32 = -1
  var returnFlag:Int64 =  -1

@TestCase
  func testPayloadState_addState_01():Unit{ 
    var str1:String = "^%#$#@#"
    let payloadState_1:PayloadState<String> = PayloadState<String>(0)
    @Assert(payloadState_1.getStates().size, 0)
    // public func addState(character: Char): PayloadState<T>
    payloadState_1.addState(' ')
    // public func getStates(): Collection<PayloadState<T>>
    var payloadStateArrL:Collection<PayloadState<String>> = payloadState_1.getStates()
    @Assert(payloadStateArrL.size, 1)
    var arr1 = payloadStateArrL.toArray()
    payloadState_1.addState('2')
    payloadState_1.addState('R')
    @Assert(payloadState_1.getStates().size, 3)

    str1 = "你好 cangjie"
    let payloadState_2:PayloadState<String> = PayloadState<String>(-6)
    payloadState_2.addState('\\')
    payloadState_2.addState('\n')
    payloadStateArrL = payloadState_2.getStates()
    arr1 = payloadStateArrL.toArray()
    @Assert(arr1.size, 2)

  }

  @TestCase
  func testPayloadState_addState_02():Unit{ 
    returnFlag = 0
    var str1:String = "^%#$#@#"
    //let payload_1: Payload<String> = Payload(str1, Option<String>.None)
    let payloadState_1:PayloadState<String> = PayloadState<String>(0)
    @Assert(payloadState_1.getStates().size, 0)
    payloadState_1.addState('$')
    var payloadStateArrL:Collection<PayloadState<String>> = payloadState_1.getStates()
    @Assert(payloadStateArrL.size, 1)
    payloadState_1.addState('^')
    payloadState_1.addState('】')
    @Assert(payloadState_1.getStates().size, 3)
    payloadState_1.addState('】')
    @Assert(payloadState_1.getStates().size, 3)

    str1 = "你好&*^&%cangjie12<>"
    let payloadState_2:PayloadState<String> = PayloadState<String>(Int32(52))

    try {
      payloadState_2.addState('\u{4f60}')
    }catch (e1:Exception) {
      println("e21:> ${e1}") 
      returnFlag = 1
    }

    try {
      payloadState_2.addState('?') // , . ?
    }catch (e1:Exception) {
      println("e22:> ${e1}") 
      returnFlag = 2
    }

    @Assert(payloadState_2.getStates().size, 2)
    let arrStates = payloadState_2.getTransitions().toArray()
    @Assert(arrStates.size, 2)

    let payloadState_3:PayloadState<String> = PayloadState<String>(Int32.Max)
    try {
      payloadState_3.addState('9') // OverflowException: add
    }catch (e1:Exception) {
      println("e23:> ${e1}") 
      @Assert(e1.toString().contains("OverflowException: add"),true)
      returnFlag = 0
    }
    @Assert(returnFlag, 0)

  }
  
}

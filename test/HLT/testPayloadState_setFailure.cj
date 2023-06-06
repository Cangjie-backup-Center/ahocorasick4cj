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
  func testPayloadState_setFailure_01():Unit{ 
    returnFlag = -1
    var str1:String = "^& 2<R>好"
    let payload_1: Payload<String> = Payload(str1, "Option<String>.None")
    let payloadState_1:PayloadState<String> = PayloadState<String>(0)
    @Assert(payloadState_1.getStates().size, 0)
    try {
      payloadState_1.failures().getOrThrow()
    }catch (e1:Exception) {
      @Assert(e1.toString().contains("NoneValueException"), true)
      returnFlag = 0
    }

    payloadState_1.addEmit(payload_1)
    payloadState_1.addState('&')
    // public func setFailure(failState: PayloadState<T>): Unit
    payloadState_1.setFailure(payloadState_1.addState('>'))
    var failures = payloadState_1.failures().getOrThrow() 
    @Assert(failures.emit().toArray().isEmpty() , true)

    @Assert(returnFlag, 0)
  }
  
}

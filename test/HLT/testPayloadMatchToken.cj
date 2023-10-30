// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj
// 3rd_party_lib_ohos:ahocorasick4cj/build/aarch64-linux-ohos/ahoCorasick4cj
from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*

@Test
public class AhoCorasickTest {
    @TestCase
    func testPayloadMatchToken_00(): Unit {
        var matcht = PayloadMatchToken<String>("bbc", PayloadEmit<String>(0, 11, "c", None))
        var mtfrag = matcht.getFragment()
        @Assert(mtfrag, "bbc")
        var ismatchs = matcht.isMatch()
        @Assert(ismatchs, true)
        var matchemit = matcht.getEmit().getOrThrow()
        var keywordmt = matchemit.getKeyword()
        @Assert(keywordmt, "c")
        var PayloadEmits = PayloadEmit<String>(0, 11, "c", None)
        var isequal = (PayloadEmits == matchemit)
        @Assert(isequal, true)
    }
}

// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import unittest.testmacro.*

main(): Int64 {
    let charSearchTest04 = CharSearchTest04()

    charSearchTest04.testCharSearch01()
    charSearchTest04.testCharSearch02()
    charSearchTest04.testCharSearch03()
    charSearchTest04.testCharSearch04()
    charSearchTest04.testCharSearch05()
    charSearchTest04.testCharSearch06()

    return 0
}

@Test
public class CharSearchTest04 {

    @TestCase
    public func testCharSearch01(): Unit {
        var trie = Trie.builder().ignoreOverlaps()
            .addKeyword("ab")
            .addKeyword("cba")
            .addKeyword("ababc")
            .build()
        var firstMatch: Emit = trie.firstMatch("ababcbab").getOrThrow()
        println(firstMatch.toString())
    }

    @TestCase
    public func testCharSearch02(): Unit {
        var trie = Trie.builder().ignoreOverlaps()
            .addKeyword("ab")
            .addKeyword("cba")
            .addKeyword("ababc")
            .build()
        try {
            trie.firstMatch("zxvzxbbwsf").getOrThrow()
        } catch (e: NoneValueException) {
            e.printStackTrace()
        }
    }

    @TestCase
    public func testCharSearch03(): Unit {
        var df: DefaultEmitHandler = DefaultEmitHandler()
        var ft: FragmentToken = FragmentToken("a")
        var dt: DefaultToken = DefaultToken(PayloadMatchToken<String>("", PayloadEmit<String>(0, 11, "c", None)))
        dt.getEmit()
        var mt: MatchToken = MatchToken("b", Emit(0, 11, ""))
        mt.isMatch()
        mt.getEmit()
        ft.getEmit()
        var t1 = ft.isMatch()
        var t2 = df.emit(Emit(0, 11, ""))
        df.getEmits()
        @Assert(t1, false)
        @Assert(t2, true)
    }

    @TestCase
    public func testCharSearch04(): Unit {
        var i: Interval = Interval(0, 11)
        var i2: Interval = Interval(5, 23)
        let t1 = i.overlapsWith(i2)
        let t2 = i.overlapsWith(10)
        i.compareTo(i2)
        @Assert(t1, true)
        @Assert(t2, true)
    }

    @TestCase
    public func testCharSearch05(): Unit {
        var ped: PayloadEmitDelegateHandler = PayloadEmitDelegateHandler(DefaultEmitHandler())
        var pft: PayloadFragmentToken<String> = PayloadFragmentToken<String>("d")
        var pmt: PayloadMatchToken<String> = PayloadMatchToken<String>("e", PayloadEmit<String>(0, 11, "c", None))
        pmt.getEmit()
        pft.getEmit()
        let t1 = ped.emit(PayloadEmit<String>(0, 11, "c", None))
        @Assert(t1, true)
    }

    @TestCase
    public func testCharSearch06(): Unit {
        var s: State = State(0)
        var sped: StatefulPayloadEmitDelegateHandler = StatefulPayloadEmitDelegateHandler(DefaultEmitHandler())
        sped.emit(PayloadEmit<String>(0, 13, "ccs", None))
        sped.getEmits()
        s.nextState('c')
        s.nextStateIgnoreRootState('b')
        var s1 = s.addState("cccd")
        var s2 = s1.addState("weeee")
        s2.getDepth()
        s2.addEmit("uuu")
        s2.emit()
        s2.failures()
        s2.getStates()
        s2.setFailure(s1)
        let col = s2.getTransitions().toArray().toString()
        @Assert(col, "[]")
    }

}

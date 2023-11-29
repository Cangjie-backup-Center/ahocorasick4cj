// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*
from std import unittest.testmacro.*

main(): Int64 {
    let charSearchTest07 = CharSearchTest07()

    charSearchTest07.testCharSearch01()
    charSearchTest07.testCharSearch02()

    return 0
}

@Test
public class CharSearchTest07 {

    @TestCase
    public func testCharSearch01(): Unit {
        var builder = Trie.builder()
            .addKeywords(["hel", "llo", "cang"])
            .onlyWholeWordsWhiteSpaceSeparated()
            .stopOnHit()
            .caseInsensitive()
            .removeOverlaps()
        var trie = builder.build()
        trie.parseText("dzxvmhelcx,mznvjwio", DefaultEmitHandler())
        let t1 = trie.containsMatch("dzxvmhelcx,mznvjwio")
        @Assert(t1, true)
    }

    @TestCase
    public func testCharSearch02(): Unit {
        let arr: ArrayList<String> = ArrayList<String>()
        arr.append("wuliuqi")
        arr.append("ccj1k4m!@@@#")
        var builder = Trie.builder()
            .addKeywords(arr)
            .removeOverlaps()
        var trie = builder.build()
        trie.parseText("dzxvmhelcx,mznvjwio", DefaultEmitHandler())
        let t1 = trie.containsMatch("dzxvmhelcx,mznvjwio")
        @Assert(t1, false)
    }

}

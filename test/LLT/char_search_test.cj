// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import unittest.testmacro.*

main(): Int64 {
    let charSearchTest = CharSearchTest()

    charSearchTest.getEmit()
    
    return 0
}

@Test
public class CharSearchTest {
    
    @TestCase
    public func getEmit(): Unit {
        var b = Trie.builder()
        var trie = b.addKeyword("hers").addKeyword("his").addKeyword("she").addKeyword("he").build()
        var emits = trie.parseText("ushers")
        var iter = emits.iterator()
        for (i in iter) {
            println(i.toString())
        }
        println("Pass1")
    }

}

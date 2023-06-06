// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*

@Test
public class AhoCorasickTest {
  var int32Res:Int32 = -1
  var strRes:String = ""
  var boolRes:Bool = false
  var returnFlag:Int64 =  -1

  @TestCase
  func testTrie_01():Unit{ 
    // public static func builder(): TrieBuilder
    let trieBuilder_1: TrieBuilder = Trie.builder()
    // public func addKeyword(keyword: String): TrieBuilder
    trieBuilder_1.addKeyword("helloq")
    trieBuilder_1.addKeyword("ello")
    trieBuilder_1.addKeyword("zzzolhh3Q")
   
    // public func build(): Trie
    let trie1:Trie = trieBuilder_1.build()
    // public func parseText(text: String): Collection<Emit>
    let emitColl_1:Collection<Emit> = trie1.parseText("helloqhh3Q")
    @Assert(emitColl_1.size,2)
    var it_1 = emitColl_1.iterator()
    for (obj in it_1) {
      strRes +=  obj.toString()
    }
    @Assert(strRes,"1:4=ello0:5=helloq")

  }

  @TestCase
  func testTrie_02():Unit{ 
    let trieBuilder_1: TrieBuilder = Trie.builder()
    trieBuilder_1.addKeyword("")
    trieBuilder_1.addKeyword("  hello")
    trieBuilder_1.addKeyword("<&^$kill me please$>")
    trieBuilder_1.addKeyword("你好，【淦】")
    trieBuilder_1.addKeyword("你好，")
    trieBuilder_1.addKeyword("你好，走开")
    var str1 = """
                hello \nbye"""
              
    var str2 = ##"
                hello \nbye"##
              
    trieBuilder_1.addKeyword(str1)
    trieBuilder_1.addKeyword(str2)

    let trie1:Trie = trieBuilder_1.build()
    // public func parseText(text: String): Collection<PayloadEmit<T>>
    let emitColl_1:Collection<Emit> = trie1.parseText("  hello <&^$kill me please$>")
    @Assert(emitColl_1.size,2)
    strRes = ""
    var it_1 = emitColl_1.iterator()
    for (obj in it_1) {
      strRes +=  obj.toString()
    }
    @Assert(strRes,"0:6=  hello8:27=<&^$kill me please$>")

    strRes = ""
    var num:Int64 = 0
    var it_2 = trie1.parseText("你好，走开").iterator()
    for (obj in it_2) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,2)
    @Assert(strRes,"0:2=你好，0:4=你好，走开")

    strRes = ""
    num = 0
    var it_3 = trie1.parseText("${str1}").iterator()
    for (obj in it_3) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,2)
    // println("strRes_3:> ${strRes}")
    @Assert(strRes,"14:20=  hello0:25=                hello \nbye")

    strRes = ""
    num = 0
    var it_4 = trie1.parseText("${str2}").iterator()
    for (obj in it_4) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,2)
    @Assert(strRes,"15:21=  hello0:27=\n                hello \\nbye")

  }

  @TestCase
  func testTrie_03():Unit{ 
    let trieBuilder_1: TrieBuilder = Trie.builder()
    trieBuilder_1.addKeyword("00")
    trieBuilder_1.addKeyword("0012")
    trieBuilder_1.addKeyword("<&00&>")
    trieBuilder_1.addKeyword(",")
    trieBuilder_1.addKeyword(",,.")
    trieBuilder_1.addKeyword("..,00")   

    let trie1:Trie = trieBuilder_1.build()
    var num:Int64 = 0
    strRes = ""
    var it_1 = trie1.parseText(" <&0012&>").iterator()
    for (obj in it_1) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,2)
    @Assert(strRes,"3:4=003:6=0012")

    strRes = ""
    num = 0
    var it_2 = trie1.parseText("..,00").iterator()
    for (obj in it_2) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,3)
    @Assert(strRes,"2:2=,0:4=..,003:4=00")

    strRes = ""
    num = 0
    var it_3 = trie1.parseText("<&00&>,,").iterator()
    for (obj in it_3) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,4)
    @Assert(strRes,"2:3=000:5=<&00&>6:6=,7:7=,")

  }
   
  @Skip
  @TestCase
  func testTrie_04():Unit{ 
    let trieBuilder_1: TrieBuilder = Trie.builder()
    trieBuilder_1.addKeyword("hello")
    trieBuilder_1.addKeyword("olloe")
    trieBuilder_1.addKeyword("elle")
    trieBuilder_1.addKeyword("llohe")

    let trie1:Trie = trieBuilder_1.build() // 添加的多个关键字，首位字符与其他关键字重复
    strRes = ""
    var num:Int64 = 0
    var it_1 = trie1.parseText("helloelles").iterator()
    for (obj in it_1) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,2)
    @Assert(strRes,"0:5=hello6:10=elle")

    strRes = ""
    num = 0
    var it_2 = trie1.parseText("lloheelle").iterator()
    for (obj in it_2) {
      strRes +=  obj.toString()
      num++
    }
    @Assert(num,2)
    // println("strRes_2:> ${strRes}")
    @Assert(strRes,"0:5=llohe6:10=elle")

  } 

}

// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj

from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*

@Test
public class AhoCorasickTest {
  var intRes:Int64 = -1
  var boolRes:Bool = false
  var returnFlag:Int64 =  -1

  @TestCase
  func testTrieConfig_01():Unit{ 
    let trieConfig_1: TrieConfig = TrieConfig()
    // public func isStopOnHit(): Bool
    boolRes = trieConfig_1.isStopOnHit()
    @Assert(boolRes,false)
    // public func setStopOnHit(stopOnHit: Bool): Unit
    trieConfig_1.setStopOnHit(true)
    boolRes = trieConfig_1.isStopOnHit()
    @Assert(boolRes,true)

    // public func isAllowOverlaps(): Bool
    boolRes = trieConfig_1.isAllowOverlaps()
    @Assert(boolRes,true)
    // public func setAllowOverlaps(allowOverlaps: Bool): Unit
    trieConfig_1.setAllowOverlaps(false)
    boolRes = trieConfig_1.isAllowOverlaps()
    @Assert(boolRes,false)

    // public func isOnlyWholeWords(): Bool
    boolRes = trieConfig_1.isOnlyWholeWords()
    @Assert(boolRes,false)
    // public func setOnlyWholeWords(onlyWholeWords: Bool): Unit
    trieConfig_1.setOnlyWholeWords(true)
    boolRes = trieConfig_1.isOnlyWholeWords()
    @Assert(boolRes,true)

  }

  @TestCase
  func testTrieConfig_02():Unit{ 
    let trieConfig_1: TrieConfig = TrieConfig()
    // public func isOnlyWholeWordsWhiteSpaceSeparated(): Bool
    boolRes = trieConfig_1.isOnlyWholeWordsWhiteSpaceSeparated()
    @Assert(boolRes,false)
    // public func setOnlyWholeWordsWhiteSpaceSeparated(onlyWholeWordsWhiteSpaceSeparated: Bool): Unit
    trieConfig_1.setOnlyWholeWordsWhiteSpaceSeparated(true)
    boolRes = trieConfig_1.isOnlyWholeWordsWhiteSpaceSeparated()
    @Assert(boolRes,true)

    // public func isCaseInsensitive(): Bool
    boolRes = trieConfig_1.isCaseInsensitive()
    @Assert(boolRes,false)
    // public func setCaseInsensitive(caseInsensitive: Bool): Unit
    trieConfig_1.setCaseInsensitive(true)
    boolRes = trieConfig_1.isCaseInsensitive()
    @Assert(boolRes,true)

  }

}

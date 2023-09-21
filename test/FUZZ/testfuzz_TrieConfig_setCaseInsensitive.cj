// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj
from ahoCorasick4cj import ahoCorasick4cj.*
from fuzz import fuzz.*

var returnFlag: Int32 = 0
let trieConfig_1: TrieConfig = TrieConfig()

func fuzz_TrieConfig_setCaseInsensitive(dp: DataProvider): Int32 {
    returnFlag = 0
  // public func setCaseInsensitive(caseInsensitive: Bool): Unit
    try {
        trieConfig_1.setCaseInsensitive(dp.consumeBool())
    } catch (e: Exception) {
        returnFlag = -1
    }

    return returnFlag
}


main() {
    Fuzzer(fuzz_TrieConfig_setCaseInsensitive).startFuzz()

    return 0
}

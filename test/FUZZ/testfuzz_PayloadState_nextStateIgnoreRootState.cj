// 3rd_party_lib:ahocorasick4cj/build/ahoCorasick4cj
from ahoCorasick4cj import ahoCorasick4cj.*
from fuzz import fuzz.*

var returnFlag: Int32 = 0
let payloadState_1: PayloadState<String> = PayloadState<String>(0)

func fuzz_PayloadState_nextStateIgnoreRootState(dp: DataProvider): Int32 {
    // public func nextStateIgnoreRootState(character: Char): ?PayloadState<T>
    try {
        payloadState_1.nextStateIgnoreRootState(dp.consumeChar())
    } catch (e: Exception) {
        returnFlag = -1
    }
    return returnFlag
}

main() {
    Fuzzer(fuzz_PayloadState_nextStateIgnoreRootState).startFuzz()

    return 0
}

/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package ahoCorasick4cj

/*
 * The class is Token
 * @since 0.38.2
 */
public abstract class Token {

    private var fragment: String

    public init(fragment: String) {
        this.fragment = fragment
    }

    public func getFragment(): String {
        return this.fragment
    }

    public func isMatch(): Bool

    public func getEmit(): ?Emit

}

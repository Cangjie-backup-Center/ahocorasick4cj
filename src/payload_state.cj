/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is PayloadEmit
 * @since 0.38.2
 */
public class PayloadState<T> {

    /**
     * effective the size of the keyword
     */
    private var depth: Int32 = 0

    /**
     * only used for the root state to refer to itself in case no matches have been
     * found
     */
    private let rootState: PayloadState<T> = PayloadState<T>()

    /**
     * referred to in the white paper as the 'goto' structure. From a state it is
     * possible to go to other states, depending on the character passed.
     */
    private let success: Map<Char, PayloadState<T>> = HashMap<Char, PayloadState<T>>()

    /**
     * if no matching states are found, the failure state will be returned
     */
    private let failure: PayloadState<T> = PayloadState<T>()

    /**
     * whenever this state is reached, it will emit the matches keywords for future
     * reference
     */
    private let emits: Set<Payload<T>> = HashSet<Payload<T>>()

    public init() {}

    /**
     * Adds a payload to be emitted for this state.
     * 
     * @param payload to be emitted.
     */
    public func addEmit(payload: Payload<T>): Unit {

    }

    public func addState(character: Char): PayloadState<T> {
        return PayloadState<T>()
    }

    public func nextStateIgnoreRootState(character: Char): PayloadState<T> {
        return PayloadState<T>()
    }

    public func nextState(character: Char): ?PayloadState<T> {
        return nextState(character, false)
    }

    private func nextState(character: Char, ignoreRootState: Bool): PayloadState<T> {
        return PayloadState<T>()
    }

    public func getStates(): Collection<PayloadState<T>> {
        return this.success.values()
    }

    public func setFailure(failState: PayloadState<T>): Unit {

    }

    public func getTransitions(): Collection<Char> {
        return this.success.keys()
    }

    public func failures(): PayloadState<T> {
        return this.failure
    }

    public func addEmit(emits: Collection<Payload<T>>): Unit {

    }

    /**
     * Returns a collection of emitted payloads for this state.
     * 
     * @return Collection of emitted payloads.
     */
    public func emit(): Collection<Payload<T>> {
        return ArrayList<Payload<T>>()
    }
}

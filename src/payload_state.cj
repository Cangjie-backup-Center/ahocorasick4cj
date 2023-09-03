/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */
package ahoCorasick4cj

/*
 * The class is PayloadState
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
    public var rootState: ?PayloadState<T> = None

    /**
     * referred to in the white paper as the 'goto' structure. From a state it is
     * possible to go to other states, depending on the character passed.
     */
    private var success: Map<Char, PayloadState<T>> = HashMap<Char, PayloadState<T>>()

    /**
     * if no matching states are found, the failure state will be returned
     */
    private var failure: ?PayloadState<T> = None

    /**
     * whenever this state is reached, it will emit the matches keywords for future
     * reference
     */
    private var emits: ?ArrayList<Payload<T>> = ArrayList<Payload<T>>()

    protected init() {
        this(0)
    }

    public init(depth: Int32) {
        this.depth = depth
        if (depth == 0) {
            this.rootState = this
        } else {
            this.rootState = None
        }
    }

    /**
     * Adds a payload to be emitted for this state.
     * 
     * @param payload to be emitted.
     */
    public func addEmit(payload: Payload<T>): Unit {
        if (let None <- this.emits) {
            this.emits = ArrayList<Payload<T>>()
        }
        this.emits.getOrThrow().append(payload)
    }

    public func addState(character: Char): PayloadState<T> {
        var nextState: ?PayloadState<T> = nextStateIgnoreRootState(character)
        if (let None <- nextState) {
            nextState = PayloadState<T>(this.depth + 1)
            this.success.put(character, nextState.getOrThrow())
        }
        return nextState.getOrThrow()
    }

    public func nextStateIgnoreRootState(character: Char): ?PayloadState<T> {
        return nextState(character, true)
    }

    public func nextState(character: Char): ?PayloadState<T> {
        return nextState(character, false)
    }

    public func getDepth(): Int32 {
        return this.depth
    }

    private func nextState(character: Char, ignoreRootState: Bool): ?PayloadState<T> {
        var nextState: ?PayloadState<T> = this.success.get(character)
        if (!ignoreRootState) {
            if (let None <- nextState) {
                if (let Some(v) <- rootState) {
                    v.depth
                    nextState = this.rootState
                }
            }
        }
        return nextState
    }

    public func getStates(): Collection<PayloadState<T>> {
        return this.success.values()
    }

    public func setFailure(failState: PayloadState<T>): Unit {
        return this.failure = failState
    }

    public func getTransitions(): Collection<Char> {
        return this.success.keys()
    }

    public func failures(): ?PayloadState<T> {
        return this.failure
    }

    public func addEmit(emits: ArrayList<Payload<T>>): Unit {
        let arr = unsafe { emits.getRawArray() }
        for(i in 0..emits.size) {
            addEmit(arr[i])
        }
    }

    /**
     * Returns a collection of emitted payloads for this state.
     * 
     * @return Collection of emitted payloads.
     */
    public func emit(): ArrayList<Payload<T>> {
        if (let None <- this.emits) {
            return ArrayList<Payload<T>>()
        }
        return this.emits.getOrThrow()
    }
}

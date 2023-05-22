## ahoCorasick4cj 库

### 介绍
该库使用 Aho-Corasick 字符串搜索算法，能够提供高效的字符串匹配功能

### 1 支持多字符搜索功能

前置条件：NA
场景：
根据给定的一个或多个关键字，在指定字符串中查找，返回匹配到目标的位置。
约束：NA 
性能： 支持版本几何性能持平
可靠性： NA

#### 1.1 主要接口

多字符搜索树类
class Trie

```cangjie

    /**
    * 构造方法，构造出一个 TrieBuilder 类对象
    * 
    * @return 返回一个 TrieBuilder 类对象
    */
    public static func builder(): TrieBuilder

    /**
    * 解析给定的文本，并返回匹配的负载
    *
    * @param text - 传入的文本信息
    *
    * @return 返回一个 Collection 集合
    */
    public func parseText(text: String): Collection<Emit>

```

多字符搜索树构建类
class TrieBuilder

```cangjie

    /**
    * 在文本搜索关键字列表中添加一个关键字
    *
    * @param keyword - 要添加到列表中的关键字
    *
    * @return 返回这个构建器
    */
    public func addKeyword(keyword: String): TrieBuilder

    /**
    * 构造方法，构造出一个 Trie 类对象
    *
    * @return 返回一个 Trie 类对象
    */
    public func build(): Trie

```

#### 1.2 其它接口

处理发出的负载
class DefaultPayloadEmitHandler

```cangjie

    /**
    * 发现一个匹配时调用的回调函数
    *
    * @param emit - 它接收一个 PayloadEmit，表示匹配的位置和负载
    *
    * @return 返回 Bool 类型
    */
    public func emit(emit: PayloadEmit<T>): Bool

    /**
    * 返回所有发出的负载的集合
    *
    * @return 返回所有发出的负载的集合
    */
    public func getEmits(): ArrayList<PayloadEmit<T>>

```

负载类
class Emit

```cangjie

    /**
    * Emit 的有参构造
    *
    * @param start - 起始位置
    * @param end - 结束位置
    * @param keyword - 关键字
    */
    public init(start: Int32, end: Int32, keyword: String)

    /**
    * 获取关键字信息
    *
    * @return 返回关键字信息
    */
    public func getKeyword(): String

    /**
    * 判断两个对象是否相等
    *
    * @param rhs - 另一个 Intervalable 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func ==(rhs: Intervalable): Bool

    /**
    * 判断两个对象是否不相等
    *
    * @param rhs - 另一个 Intervalable 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func !=(rhs: Intervalable): Bool

    /**
    * 计算 hash 值
    *
    * @return 返回 Int64 类型
    */
    public func hashCode(): Int64

    /**
    * 重写 toString 方法
    *
    * @return 返回字符串信息
    */
    public func toString(): String
```

时间间隔类
class Interval

```cangjie

    /**
    * Interval 的有参构造
    *
    * @param start - 起始位置
    * @param end - 结束位置
    */
    public init(start: Int32, end: Int32)

    /**
    * 获取起始位置
    *
    * @return 返回 Int32 类型
    */
    public func getStart(): Int32

    /**
    * 获取结束位置
    *
    * @return 返回 Int32 类型
    */
    public func getEnd(): Int32

    /**
    * 返回时间间隔长度
    *
    * @return 返回 Int32 类型
    */
    public func size(): Int32

    /**
    * 重写 toString 方法
    *
    * @return 返回字符串信息
    */
    public open func toString(): String

    /**
    * 判断两个对象是否相等
    *
    * @param rhs - 另一个 Intervalable 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func ==(rhs: Intervalable): Bool

    /**
    * 判断两个对象是否不相等
    *
    * @param rhs - 另一个 Intervalable 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func !=(rhs: Intervalable): Bool

    /**
    * 计算 hash 值
    *
    * @return 返回 Int64 类型
    */
    public open func hashCode(): Int64

```

自定义载体类
class Payload

```cangjie

    /**
    * Payload 的有参构造
    *
    * @param keyword - 关键字信息
    * @param data - 对应的 data 数据
    */
    public init(keyword: String, data: ?T)

    /**
    * 获取关键字信息
    *
    * @return 返回 String 类型
    */
    public func getKeyword(): String

    /**
    * 获取对应的 data 数据
    *
    * @return 返回 Option 类型
    */
    public func getData(): ?T

    /**
    * 判断两个对象是否相等
    *
    * @param rhs - 另一个 Payload 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func ==(rhs: Payload<T>): Bool

    /**
    * 判断两个对象是否不相等
    *
    * @param rhs - 另一个 Payload 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func !=(rhs: Payload<T>): Bool

    /**
    * 计算 hash 值
    *
    * @return 返回 Int64 类型
    */
    public open func hashCode(): Int64

    /**
    * 自定义比较器方法
    *
    * @param other - 另一个 Payload 对象
    *
    * @return 返回 Ordering 类型
    */
    public func compare(other: Payload<T>): Ordering

```

自定义载体负载类
class PayloadEmit

```cangjie

    /**
    * PayloadEmit 的有参构造
    *
    * @param start - 起始位置
    * @param end - 结束位置
    * @param keyword - 关键字信息
    * @param payload - 对应的载体数据
    */
    public init(start: Int32, end: Int32, keyword: String, payload: ?T)

    /**
    * 获取关键字信息
    *
    * @return 返回 String 类型
    */
    public func getKeyword(): String

    /**
    * 获取对应的载体数据
    *
    * @return 返回 Option 类型
    */
    public func getPayload(): ?T

    /**
    * 重写 toString 方法
    *
    * @return 返回 String 类型
    */
    public func toString(): String

    /**
    * 判断两个对象是否相等
    *
    * @param rhs - 另一个 Payload 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func ==(rhs: Intervalable): Bool

    /**
    * 判断两个对象是否不相等
    *
    * @param rhs - 另一个 Payload 对象
    *
    * @return 返回 Bool 类型
    */
    public operator func !=(rhs: Intervalable): Bool

    /**
    * 计算 hash 值
    *
    * @return 返回 Int64 类型
    */
    public func hashCode(): Int64

```

载体状态类
class PayloadState

```cangjie

    /**
    * PayloadState 的有参构造
    *
    * @param depth - 关键字的有效大小
    */
    public init(depth: Int32)

    /**
    * 向该状态节点添加一个发出的负载，即当到达该状态节点时，需要输出的负载
    *
    * @param payload - 自定义载荷
    */
    public func addEmit(payload: Payload<T>): Unit

    /**
    * 向该状态节点添加一个子状态节点，即在状态转移图中与该状态节点相连的下一个状态节点

    * @param character - 传入的字符
    *
    * @return 返回 Option 类型
    */
    public func addState(character: Char): PayloadState<T>

    /**
    * 获取该状态节点在给定字符下的子状态节点，如果没有匹配的子状态节点，则返回空指针
    *
    * @param character - 传入的字符
    *
    * @return 返回 Option 类型
    */
    public func nextStateIgnoreRootState(character: Char): ?PayloadState<T>

    /**
    * 获取该状态节点在给定字符下的子状态节点，如果没有匹配的子状态节点，则返回失败状态节点或根状态节点
    *
    * @param character - 传入的字符
    *
    * @return 返回 Option 类型
    */
    public func nextState(character: Char): ?PayloadState<T>

    /**
    * 获取该状态节点的所有子状态节点的集合
    *
    * @return 返回所有子状态节点的集合
    */
    public func getStates(): Collection<PayloadState<T>>

    /**
    * 设置该状态节点的失败状态节点，即在状态转移图中当没有匹配的子状态节点时，需要跳转到的状态节点
    *
    * @param failState - 传入 PayloadState 对象
    *
    * @return 返回 Int64 类型
    */
    public func setFailure(failState: PayloadState<T>): Unit

    /**
    * 获取该状态节点的所有转移字符的集合
    *
    * @return 返回所有转移字符的集合
    */
    public func getTransitions(): Collection<Char>

    /**
    * 获取该状态节点的失败状态节点，即在状态转移图中当没有匹配的子状态节点时，需要跳转到的状态节点
    *
    * @return 返回该状态节点的失败状态节点
    */
    public func failures(): PayloadState<T>

    /**
    * 向该状态节点添加一个发出的负载集合
    *
    * @param emits - 传入一个发出的负载集合
    */
    public func addEmit(emits: Collection<Payload<T>>): Unit

    /**
    * 获取该状态节点的所有发出的负载的集合，即当到达该状态节点时，需要输出的负载
    *
    * @return 返回所有发出的负载的集合
    */
    public func emit(): Collection<Payload<T>>
    
```

搜索树配置类
class TrieConfig

```cangjie

    /**
    * 判断 Trie 或 PayloadTrie 是否在找到第一个关键词后停止
    *
    * @return 返回 Bool 类型
    */
    public func isStopOnHit(): Bool
    
    /**
    * 设置是否在找到第一个关键词后停止
    *
    * @param stopOnHit - Bool 类型
    */
    public func setStopOnHit(stopOnHit: Bool): Unit

    /**
    * 判断 Trie 或 PayloadTrie 是否允许重叠
    *
    * @return 返回 Bool 类型
    */
    public func isAllowOverlaps(): Bool

    * 设置是否允许重叠
    *
    * @param allowOverlaps - Bool 类型
    */
    public func setAllowOverlaps(allowOverlaps: Bool): Unit

    /**
    * 判断 Trie 或 PayloadTrie 是否只匹配整个单词
    *
    * @return 返回 Bool 类型
    */
    public func isOnlyWholeWords(): Bool

    /**
    * 设置是否只匹配整个单词的
    *
    * @param onlyWholeWords - Bool 类型
    */
    public func setOnlyWholeWords(onlyWholeWords: Bool): Unit

    /**
    * 判断 Trie 或 PayloadTrie 是否只匹配空格分隔的单词
    *
    * @return 返回 Bool 类型
    */
    public func isOnlyWholeWordsWhiteSpaceSeparated(): Bool

    /**
    * 设置是否只匹配空格分隔的单词
    *
    * @param onlyWholeWordsWhiteSpaceSeparated - Bool 类型
    */
    public func setOnlyWholeWordsWhiteSpaceSeparated(onlyWholeWordsWhiteSpaceSeparated: Bool): Unit

    /**
    * 判断 Trie 或 PayloadTrie 是否忽略大小写
    *
    * @return 返回 Bool 类型
    */
    public func isCaseInsensitive(): Bool

    /**
    * 设置是否忽略大小写
    *
    * @param caseInsensitive - Bool 类型
    */
    public func setCaseInsensitive(caseInsensitive: Bool): Unit
```

表示一个区间树的节点类
class IntervalNode

```cangjie

    /**
    * 构造方法，构造出一个 IntervalNode 类对象
    *
    * @param intervals - 传入一个 ArrayList 集合
    *
    * @return 返回一个 IntervalNode 类对象
    */
    public static func newInstance(intervals: ArrayList<Intervalable>): IntervalNode

    /**
    * 根据该节点包含的所有区间的起点和终点，计算出一个合适的中点值，使得左子树和右子树的区间数量尽量平衡
    *
    * @param intervals - 传入一个 ArrayList 集合
    *
    * @return 返回一个 Int32 类型
    */
    public static func determineMedian(intervals: ArrayList<Intervalable>): Int32

    /**
    * 查找该节点包含或重叠的所有区间
    *
    * @param intervals - 传入一个 Intervalable 类对象
    *
    * @return 返回一个 ArrayList 集合
    */
    public func findOverlaps(interval: Intervalable): ArrayList<Intervalable>
```

表示一个区间树类
class IntervalTree

```cangjie

    /**
    * IntervalTree 的有参构造
    *
    * @param intervals - 传入一个 ArrayList 集合
    */
    public init(intervals: ArrayList<Intervalable>)

    /**
    * 移除该节点包含或重叠的所有区间
    *
    * @param intervals - 传入一个 ArrayList 集合
    *
    * @return 返回移除后的 ArrayList 集合
    */
    public func removeOverlaps(intervals: ArrayList<Intervalable>): ArrayList<Intervalable>

    /**
    * 查找该节点包含或重叠的所有区间
    *
    * @param intervals - 传入一个 Intervalable 类对象
    *
    * @return 返回一个 ArrayList 集合
    */
    public func findOverlaps(interval: Intervalable): ArrayList<Intervalable>
```

负载状态实现构建类
class PayloadTrieBuilder

```cangjie

    /**
    * 构造方法，构造出一个 PayloadTrie 类对象
    *
    * @return 返回一个 PayloadTrie 类对象
    */
    public func build(): PayloadTrie<T>

    /**
    * 在文本搜索关键字列表中添加一个关键字
    *
    * @param keyword - 要添加到列表中的关键字
    *
    * @return 返回这个构建器
    */
    public func addKeyword(keyword: String): PayloadTrieBuilder<T>

    /**
    * 在文本搜索关键字列表中添加一个关键字
    *
    * @param keyword - 要添加到列表中的关键字
    * @param keyword - 要添加的有效载荷
    *
    * @return 返回这个构建器
    */
    public func addKeyword(keyword: String, payload: ?T): PayloadTrieBuilder<T>

```

负载状态实现类
class PayloadTrie

```cangjie

    /**
    * 构造方法，构造出一个 PayloadTrieBuilder 类对象
    *
    * @return 返回一个 PayloadTrieBuilder 类对象
    */
    public static func builder(): PayloadTrieBuilder<T>

    /**
    * 解析给定的文本，并返回匹配的负载
    *
    * @param text - 传入的文本信息
    *
    * @return 返回一个 Collection 集合
    */
    public func parseText(text: String): Collection<PayloadEmit<T>>

    /**
    * 解析给定的文本，并返回匹配的负载
    *
    * @param text - 传入的文本信息
    * @param emitHandler - 用于处理发出的负载的事件处理器
    *
    * @return 返回一个 Collection 集合
    */
    public func parseText(text: String, emitHandler: StatefulPayloadEmitHandler<T>): Collection<PayloadEmit<T>>

    /**
    * 解析给定的文本，并返回匹配的负载
    *
    * @param text - 传入的文本信息
    * @param emitHandler - 用于处理发出的负载的事件处理器
    */
    public func parseText(text: String, emitHandler: PayloadEmitHandler<T>): Unit
```

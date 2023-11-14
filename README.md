<div align="center">
<h1>ahoCorasick4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.39.8-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-94.8%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

使用 Aho-Corasick 字符串搜索算法，能够提供高效的字符串匹配功能

### 特性

- 🚀 支持多字符搜索
- 🚀 支持关键词库模式
- 🚀 支持自定义值输出模式

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 流程图

<p align="center">
<img src="./doc/assets/readme-icon-liu.jpg" width="60%" >
</p>


### 源码目录

```shell
├── doc
│   ├── assets
│   ├── feature_api.md
├── src
│   ├── abstract_stateful_emit_handler.cj
│   ├── abstract_stateful_payload_emit_handler.cj
│   ├── default_emit_handler.cj
│   ├── default_payload_emit_handler.cj
│   ├── default_token.cj
│   ├── emit_handler.cj
│   ├── emit.cj
│   ├── fragment_token.cj
│   ├── interval_node.cj
│   ├── interval_tree.cj
│   ├── interval.cj
│   ├── intervalable.cj
│   ├── match_token.cj
│   ├── payload_emit_delegate_handler.cj
│   ├── payload_emit_handler.cj
│   ├── payload_emit.cj
│   ├── payload_fragment_token.cj
│   ├── payload_match_token.cj
│   ├── payload_state.cj
│   ├── payload_token.cj
│   ├── payload_trie_builder.cj
│   ├── payload_trie.cj
│   ├── payload.cj
│   ├── state.cj
│   ├── stateful_emit_handler.cj
│   ├── stateful_payload_emit_delegate_handler.cj
│   ├── stateful_payload_emit_handler.cj
│   ├── token.cj
│   ├── trie_builder.cj
│   ├── trie_config.cj
│   ├── trie.cj
└── test   
    ├── doc
    ├── FUZZ
    ├── HLT
    ├── LLT
├── CHANGELOG.md
├── gitee_gate.cfg
├── LICENSE
├── module.json
├── README.md
├── README.OpenSource
```

- `DOC` 存放本库使用文档
- `src` 是库源码目录
- `test` 是存放测试用例的文件夹，含有 DOC 功能示例、FUZZ 测试用例、HLT 测试用例、LLT 自测用例

### 接口说明

主要是核心类和成员函数说明,详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译构建

#### linux环境编译

编译描述和具体shell命令

```shell
cjpm build
```

#### Windows环境编译

编译描述和具体cmd命令

```cmd
cjpm build
```

### 执行用例
编译用例并执行，步骤如下：

#### 1. 进入 test/ 目录下创建 tmp 文件夹，然后编译测试用例
```shell
cd test/
mkdir tmp
cjc -O2 --import-path xxxxx/build/release -L xxxxx/build/release/ahoCorasick4cj -l ahoCorasick4cj_ahoCorasick4cj test/HLT/testTrie.cj -o test/tmp/test.cj.out --test
```

##### 1.1 具体说明

- cjc命令, -O2表示开启优化
```shell
cjc -O2
```
- --import-path 导入 ahoCorasick4cj 库编译出来的库文件地址, 注意地址最后有".."
- xxx 代表自己的工作目录，应替换成自己的实际工作目录
- -L 导入库文件的完整路径
- 导入多个库,每个库都需要--import-path和 -L

```shell
--import-path xxxxx/build/release -L xxxxx/build/release/ahoCorasick4cj -l ahoCorasick4cj_ahoCorasick4cj
```
- -l 要导入的具体的包, 用"库名_包名",一般库文件生成时是"lib库名_包名.后缀"的格式
- 导入一个库中有多个包时,用多个 -l

- 测试用例的完整路径和用例中引入文件的完整路径
- -o 用例编译后输出的位置和名称, .out结尾, 一般使用"用例名称.out"
- --test 用例编译命令结尾
```shell
test/HLT/testTrie.cj -o test/tmp/test.cj.out --test
```

#### 2. 把编译好的文件复制到 .out 文件下(test/tmp/) 
- 把build/release/ahoCorasick4cj 目录中的文件都复制到 .out 文件位置(test/tmp/ 中)

#### 3. 进入到.out文件位置，执行用例
- 进入到.out文件位置执行用例
```shell
cd test/tmp
```
- windows系统打开cmd,输入.out文件完整名称即可执行
```shell
test.cj.out
```
- Linux系统使用 ./.out文件完整名称
```shell
./test.cj.out
```

### 功能示例

### 多字符搜索功能示例

```cangjie
from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import unittest.testmacro.*

main(): Int64 {
    let charSearchTest03 = CharSearchTest01()
    charSearchTest01.testCharSearch01()
}

@Test
public class CharSearchTest01 {

    @TestCase
    public func testCharSearch01(): Unit {
        var builder = Trie.builder()
        var trie = builder.addKeyword("hers").addKeyword("his").addKeyword("she").addKeyword("he").build()
        var emits = trie.parseText("ushers")
        var iter = emits.iterator()
        for (i in iter) {
            println(i.toString())
        }
    }
}
```

执行结果如下：

```shell
1:3=she
2:3=he
2:5=hers
```

### 关键词库模式功能示例

```cangjie
from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import collection.*
from std import unittest.testmacro.*

main(): Int64 {
    let charSearchTest05 = CharSearchTest05()
    charSearchTest05.testCharSearch01()
    return 0
}

@Test
public class CharSearchTest05 {

    @TestCase
    public func testCharSearch01(): Unit {

        let speech: String = "The Answer to the Great Question... Of Life, " +
            "the Universe and Everything... Is... Forty-two,' said " +
            "Deep Thought, with infinite majesty and calm."

        var trie = Trie.builder().ignoreOverlaps().onlyWholeWords().ignoreCase()
            .addKeyword("great question")
            .addKeyword("forty-two")
            .addKeyword("deep thought")
            .build()
        var tokens = trie.tokenize(speech)
        var html: StringBuilder = StringBuilder()
        html.append("<html><body><p>")

        for (token in tokens) {
            if (token.isMatch()) {
            html.append("<i>")
        }

        html.append(token.getFragment())
        if (token.isMatch()) {
            html.append("</i>")
        }
    }

        html.append("</p></body></html>")
        println(html)
    }
}

```

执行结果如下：

```shell
<html><body><p>The Answer to the <i>Great Question</i>... Of Life, the Universe and Everything... Is... <i>Forty-two</i>,' said <i>Deep Thought</i>, with infinite majesty and calm.</p></body></html>
```

### 自定义值输出模式功能示例

```cangjie
from ahoCorasick4cj import ahoCorasick4cj.*
from std import unittest.*
from std import unittest.testmacro.*

main(): Int64 {
    let charSearchTest06 = CharSearchTest06()
    charSearchTest06.testCharSearch01()
    return 0
}

@Test
public class CharSearchTest06 {

    @TestCase
    public func testCharSearch01(): Unit {
        var trie = PayloadTrie<Word>.builder()
            .addKeyword("hers", Word("f"))
            .addKeyword("his", Word("m"))
            .addKeyword("she", Word("f"))
            .addKeyword("he", Word("m"))
            .addKeyword("nonbinary", Word("nb"))
            .addKeyword("transgender", Word("tg"))
            .build()
        var emits: Collection<PayloadEmit<Word>> = trie.parseText("ushers")
        var iter: Iterator<PayloadEmit<Word>> = emits.iterator()
        for (i in iter) {
            println(i.toString() + i.getPayload().getOrThrow().gender)
        }
    }
}

class Word {
    protected var gender: String
    public init(gender: String) {
        this.gender = gender
    }
}


```

执行结果如下：

```shell
1:3=she->f
2:3=he->m
2:5=hers->f
```

注意：用例需放入 `test/LLT` 下，执行步骤是: 本项目编译运行方式

## 开源协议

Apache License 2.0

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。

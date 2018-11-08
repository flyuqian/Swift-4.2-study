//
//  CollectionTypeController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/7.
//  Copyright © 2018 com.test. All rights reserved.
//


/*
 Swift 中 print 的使用
 - separator 分割符, 默认是 " ", 使用: print(x,y,z, separator: "--")
 - terminator 结束符, 默认是 \n, 使用: print(x,y,z, separator: "--", terminator:":)")
 */



import UIKit

class CollectionTypeController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
    }
    


    
}


extension CollectionTypeController {
    
    //
    /// 集合类型是稳定的序列, 可以保证多次遍历保持一致, 索引获取h元素, 元素数量有限
    // Collection 协议建立在 Sequence 协议上
    //
    /// 自定义的集合类型
    // 队列的设计
    //
    
    fileprivate func test1() {
        var q = FIFOQueue<String>()
        for x in ["1", "2", "foo", "3"] {
            q.enqueue(x)
        }
        for s in q {
            print(s, terminator: " ")
        }
        
        // 可以将 q 传递给接受序列的方法
        var a = Array(q)
        a.append(contentsOf: q[2...3])
        
        // 可以调用Sequence 的拓展方法和属性
        q.map { $0.uppercased() }
        q.sorted()
        q.flatMap { Int($0) }
        // 可以调用Collection的拓展方法和属性
        q.isEmpty
        q.count
        q.first
    }
    
}

// 队列设计
fileprivate protocol Queue {
    associatedtype Element
    
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}
// 均摊 pop的复杂度
fileprivate struct FIFOQueue<Element>: Queue {
    private var left: [Element] = []
    private var right: [Element] = []
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}
// 遵守collection协议
// 满足 collection 协议的最小需求, 被写在了文档中
// startIndex 和 endIndex 属性
// 至少能读取你的类型中的元素的下标方法
// 用来在集合索引之间进行步进的index(after:)方法
extension FIFOQueue: Collection {
    var startIndex: Int { return 0 }
    var endIndex: Int { return left.count + right.count }
    
    func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    // precondition 为运行期检查, 当条件不为真时, 程序提前退出, 避免因数据错误造成的更大损失

    // 下标方法
    subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        }
        else {
            return right[position - left.count]
        }
    }
    
}
// 当实现一个类似队列这样的集合类型时, 最好实现 ExpressibleByArrayLiteral, 让用户可以用[value, value]的方式创建一个队列
// 这里的 [value, value, value] 只是数组字面量
extension FIFOQueue: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}

// 关联类型
// Collection已经为除了 Index 和 Element 以外的关联类型提供了默认值
// Iterator 是从Sequence 继承的关联类型
// IndexingIterator
// SubSequence
// IndexDistance 代表两个索引之间的步数
// Indices 集合的indices 属性的返回值类型


//
/// 索引
// startIndex是指第一个元素的位置, endIndex是集合中最后一个元素之后的位置(非有效下标)
// 集合的索引, 一般使用整数, 但这不是必须, Index的唯一要求是实现 Comparable, 即索引必须有确定的顺序
// Dictionary 的索引不是 key, 因为无法增加一个键, 不能给出某个键之后的索引值应该是什么, 使用索引访问下标应该立即返回获取元素, 而不是搜索或者计算哈希值
// 字典的索引是 DictionaryIndex类型, 是字典内部存储缓冲区的不透明的值, 事实上是一个Int偏移值的封装
// 字典的 Element类型是 key value 多元组

//
/// 索引失效
// 集合发生改变, 索引可能失效(索引不指向原来的元素, 索引无效)

//
/// 索引步进
//

//
/// 自定义集合索引
// split 方法会计算出整个数组,
// 下面构建一个 Words集合, 不一次性的计算出所有单词, 而是通过延迟加载的方式进行迭代
fileprivate extension Substring {
    var nextWordRange: Range<Index> {
        let start = drop(while: {$0 == " "})
        let end = start.index(where: {$0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
}
fileprivate struct WordsIndex: Comparable {
    fileprivate let range: Range<Substring.Index>
    fileprivate init(_ value: Range<Substring.Index>) {
        self.range = value
    }
    static func <(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }
    static func ==(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range == rhs.range
    }
}
fileprivate struct Words: Collection {
    
    let string: Substring
    let startIndex: WordsIndex
    
    init(_ s: String) {
        self.init(s[...])
    }
    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
    var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }
}
extension Words {
    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }
}
extension Words {
    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else {
            return endIndex
        }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}
// FIXME: 上边的自定义索引几乎就是抄了一遍, 不懂




//
// MARK: 切片
// 所有的集合类型都有切片的默认实现, 并且有一个接受Range<Index>作为参数的下标方法
// Slice非常适合作为默认子类型, 对于自定义集合类型, 最好考虑是否能将集合类型本身当坐它的SubSequence 使用

/// 切片和原集合共享索引
// Collection协议有一个正式的要求, 切片的索引可以和原集合的索引互换使用

/// 泛型 PrefixIterator



// MARK: 专门的集合类型
// 标准库将Collection的需求控制在最小
// 针对特定的需求提供特定的Collection封装
/*
 BidirectionalCollection — “一个既支持前向又支持后向遍历的集合。”
 
 RandomAccessCollection — “一个支持高效随机存取索引遍历的集合。”
 
 MutableCollection — “一个支持下标赋值的集合。”
 
 RangeReplaceableCollection — “一个支持将任意子范围的元素用别的集合中的元素进行替换的集合。”
 
 */



// MARK: 双向索引 BidirectionalCollection
// 只增加了 index(before:)方法
// ....
// TODO: 对于集合类型, 越看越懵逼, 所以这四种集合类型先不看了, 有空再补上

// 这些专门的集合协议可以被很好地组合起来, 作为一组约束, 来匹配每个特定算法的要求, 如下
//extension MutableCollection where Self: RandomAccessCollection, Element: Comparable {
//    /// 原地对集合进行排序
//    public mutating func sort() { ... }
//}





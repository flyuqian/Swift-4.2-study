//
//  ShowArray2ViewController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/10/30.
//  Copyright © 2018 com.test. All rights reserved.
//

//
// 内见集合类型
// 

import UIKit

class ShowArray2ViewController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        test1()
//        test2()
//        test3()
        test4()
        
        
        
    }
    
    
    
    
    /// Range
    // 范围代表的是两个值得区间, 由上下边界进行定义 ..< / ...
    // 只有半开范围能表达空间隔(上下边界相等的情况)如 5..<5
    // 只有闭合范围能包括其元素类型所能表达的最大值, 如 0...Int.max, 而半开范围则要求范围上界是一个比自身所包含的最大值还要大1的值
    fileprivate func test4() -> Void {
        let singleDigitNumber = 0..<10
        let _ = Array(singleDigitNumber)
        
        let lowercaseLetters = Character("a")...Character("z")
        
        // 表示单边范围
        let _ = 0...
        let _ = ..<Character("z")
        
        // ..< 和 ... 都有一个 Bound 的泛型参数, 对于Bound的唯一要求是必须遵守 Comparable协议
        let ra = singleDigitNumber.contains(9)
        let rb = lowercaseLetters.overlaps("c"..<"f")
        print("ra: \(ra) + rb: \(rb)")
        
    }
    /// 可数范围
    // 0..<10 的类型其实是一个CountableRange<Int>, 其遵守Strideable(以整数位步长)协议, Swift将这类范围成为可数范围
    // 可数范围的类型可以是整数或者指针类型, 不能是一个浮点数, 因为 Stride类型中有一个整数的约束
    // 如果对浮点数进行迭代, 可以用: stride(from: to: by) 和: stride(frome: through: by)来创建序列进行迭代
    // Stridedable e的约束, 使得CountableRange和countableClosedRange遵守 RandomAccessCollection, 于是我们可以对他们进行迭代
    //
    //                    半开范围            闭合范围
    // 元素满足 Comparable  Range            ClosedRange
    // 元素满足 Strideable  CountableRange   CountableClosedRange
    //
    //// 部分范围
    // 部分范围, 是☞将 ... 或 ..< 作为前置或后置运算符来使用时所构造的范围
    // 如:
    // Partial 直译: 部分
    fileprivate let fromA: PartialRangeFrom<Character> = Character("a")...
    fileprivate let throughZ: PartialRangeThrough<Character> = ...Character("z")
    fileprivate let upto10: PartialRangeUpTo<Int> = ..<10
    fileprivate let fromFive: CountablePartialRangeFrom<Int> = 5...
    // 能够技术的只有 CountablePartialRangeFrom 这一种类型, 也只有该类型能被迭代, 但是使用时注意添加break条件
    //
    /// 范围表达式
    // 所有这8种范围都满足 RangeExpression协议, 该协议如下
    // public protocol RangeExpression {
    //    associatedtype Bound: Comparable
    //    func contains(_ element: Bound) -> Bool
    //    func relative<C: _Indexable>(to collection: C) -> Range<Bound>
    //        where C.Index == Bound
    // }
    // 对于下届确实的部分范围, relative(to:) 方法会把集合类型的startIndex作为范围下界
    // 对于上界确实的部分范围, 同样, 它会使用endIndex作为上界, 这样,不认范围就能使集合切片的语法变得相当紧凑
    // let arr = [1, 2, 3, 4]; arr[2...]; arr[..<1]; arr[1...2];
    // 这些写法能够在正常工作, 是因为Collection协议里对应的下标操作声明中, 所接收的是一个RangeExpression参数, 而不是上述八个具体的范围类型中的摸一个,可以省掉上下边界: arr[...]
    //
    /// 范围和按条件遵守协议
    
    
    
    
    
    
    /// Hashable 要求
    // 字典其实是 哈希表, 字典通过 hashValue来为每个键制定一个位置, 以及他对应的储存, 标准库中的所有类型都s遵守Hashable协议, 不带关联值的美剧也自动遵守 Hashable
    // 自定义类型用做字典的键, 必须遵守 Hashable, 实现 hashValue 和 == 运算符, 你的实现必须保证哈希不变原则, 两个相同的实例, 必须拥有相同的hash值, 反过来不必为真
    //
    // Set也是通过哈希表实现的, 集合中的元素必须满足 hashable
    //
    // 集合代数
    //
    fileprivate func test3() {
        let iPods: Set = ["iPod touch", "iPod nano", "iPod mini",
        "iPod shuffle", "iPod Classic"]
        let discontinuedIPods: Set = ["iPod mini", "iPod Classic",
                                      "iPod nano", "iPod shuffle"]
        // 补集
        let currentIPods = iPods.subtracting(discontinuedIPods) // ["iPod touch"]
        print(currentIPods)
        
        // 交集
        let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
        let iPodWithTouch = iPods.intersection(touchscreen);
        print(iPodWithTouch)
        
        // 并集
        var discontinued: Set = ["iBook", "Powerbook", "Power Mac"]
        discontinued.formUnion(discontinuedIPods)
        print(discontinued);
        
        
    }
    //
    // 索引集合 和 字符集合
    // Set 和 OptionSet 是标准库中唯一实现了 SetAlgebra的类型, 该协议还被Foundation中的IndexSet和CharacterSet实现
    // IndexSet 表示了一个由正整数组成的集合, 如果需要操作其内部范围, 可以操作IndexSet暴露的rangeView属性
    
    
    
    
    
    /// 字典
    fileprivate func test2() {
        enum Setting {
            case text(String)
            case int(Int)
            case bool(Bool)
        }
        let defaultSettings: [String : Setting] = [
            "AirPlane Model" : .bool(false),
            "Name" : .text("My iPhone")
        ]
        print(defaultSettings["Name"] ?? "")
        
        var userSetting = defaultSettings
        userSetting.updateValue(.int(4), forKey: "value")
        print(userSetting)
        
        let overriddenSettings: [String : Setting] = ["Name" : .text("Jane iPhone")]
        userSetting.merge(overriddenSettings, uniquingKeysWith: {$1})
        print(userSetting)
    }
    
    
    

    /// 数组切片
    fileprivate func test1() {
        
        // 想要获取数组中除了首个元素的其他元素
        let fibs = [0, 1, 1, 2, 3, 5, 8]
        let slice = fibs[1...]
        print(type(of: slice))
        
        // 切片类型只是数组的一种表达方式, 背后的数据依旧是原来的数组, 只不过用切片的方式来表示
        // 这意味着原来的数组并不需要被复制, ArraySlice具有Array上定义的方法一致, 可以转换为数组
        
        // Swift数组可以桥街到OC中, NSArray只能持有对象, 所以对其不兼容的值(比如枚举)用一个不透明的box对象包装, 而Int, String等自动桥接为OC类型
    }

}

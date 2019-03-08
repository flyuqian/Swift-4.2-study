//
//  TReloadC.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2019/2/25.
//  Copyright © 2019 com.test. All rights reserved.
//

import UIKit

class TReloadC: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
    }
    


    func test1() {
        
        let arr1 = [1, 2, 3]
        let arr2 = [5, 4, 3, 2, 1];
        let rst = arr1.isSubset(of: arr2)
        print(rst)
        
        let isEvent = { $0 % 2 == 0 }
        print((0..<5).contains(where: isEvent))
        print([1, 3, 99].contains(where: isEvent))
    }

}




//MARK: 使用闭包对行为进行参数化
// isSubset还有更加通用化的可能, 如不满足Equatable的数组
/*   标准库有下面版本的 contains
    它接受一个函数, 该函数会对每一个元素进行检查,
extension Sequence {
    /// 根据序列是否包含满足给定断言的元素，返回一个布尔值。
    func contains(where predicate: (Element) throws -> Bool)
        rethrows -> Bool
}
 let isEvent = { $0 % 2 == 0 }
 print((0..<5).contains(where: isEvent))
 true
 print([1, 3, 99].contains(where: isEvent))
 false
 */
fileprivate extension Sequence {
    func isSubset<S: Sequence>(of other: S, by areEquivalent: (Element, S.Element) -> Bool) -> Bool {
        for element in self {
            guard other.contains(where: { areEquivalent(element, $0) }) else {
                return false
            }
        }
        return true
    }
}
/*
 现在，我们可以将 isSubset 用在数组的数组上了，只需要为它提供一个闭包表达式，并使用 == 来对数组进行比较。不幸的是，如果我们导入了 Foundation，另一个对类型检查器的性能优化将会导致编译器不再确定到底应该使用哪个 ==，从而使编译发生错误。我们需要在代码的某个地方加上类型标注：
 
 [[1,2]].isSubset(of: [[1,2] as [Int], [3,4]]) { $0 == $1 } // true
 只要你提供的闭包能够处理比较操作，这两个序列中的元素甚至都不需要是同样类型的元素：
 
 let ints = [1,2]
 let strings = ["1","2","3"]
 ints.isSubset(of: strings) { String($0) == $1 } // true
 */





//MARK: 使用泛型约束进行重载
// 情景, 我们想要知道第一个数组是不是第二个数组的子集(不考虑顺序),
//  标准库中提供了isSubset(of:)方法, 该方法只适用于 满足了SetAlgebra协议的类型
// 于是, 我们可以写一个范围更广泛的 isSubset(of:)方法
fileprivate extension Sequence where Element: Equatable {
    func isSubset(of other: [Element]) -> Bool {
        for element in self {
            guard other.contains(element) else { return false }
        }
        return true
    }
}
// 这个 isSubset(of:) 时间复杂度为O(nm), nm分别代表两个数组的数量
// 下面通过收紧元素类型的限制来提高性能
// 如果other数组的元素满足Hashable, 就可以将数组替换为set
// otherSet.contains(element), 为常数时间
// 循环:O(n), contains: O(1), array->set: O(m), 此时复杂度 O(n+m)
fileprivate extension Sequence where Element: Hashable {
    func isSubset(of other: [Element]) -> Bool {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else { return false }
        }
        return true
    }
}
// 我们可以保留以上两个版本, 编译器会根据参数类型挑选使用哪一个
// Swift不仅可以通过输入输出类型重载, 还可以通过占位符的约束来重载
// isSubset还可以更通用,
fileprivate extension Sequence where Element: Hashable {
    func isSubset<S: Sequence>(of other: S) -> Bool
        where S.Element == Element {
            let otherSet = Set(other)
            for element in self {
                guard otherSet.contains(element) else {
                    return false
                }
            }
            return true
    }
}




//MARK: 运算符重载
// 幂运算比乘法运算优先级更高
// 定义一个 幂运算运算符
precedencegroup ExponentiationPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}
infix operator **: ExponentiationPrecedence
func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}
func **(lhs: Float, rhs: Float) -> Float {
    return powf(lhs, rhs)
}
// 定义一个泛型重载
func **<I: BinaryInteger>(lhs: I, rhs: I) -> I {
    let result = Double(Int64(lhs)) ** Double(Int64(rhs))
    return I(result)
}
// 调用 let a = 2 ** 3, 编译器报错
// “对于重载的运算符，类型检查器会去使用非泛型版本的重载，而不考虑泛型版本。”
// => 非泛型函数 优先泛型函数
// “要让编译器选择正确的重载，我们需要至少将一个参数显式地声明为整数类型，或者明确提供返回值的类型”
// 所以  let a: Int = 2 ** 3 没问题



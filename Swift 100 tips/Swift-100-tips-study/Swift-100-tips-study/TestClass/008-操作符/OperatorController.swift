//
//  OperatorController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 支持重载操作符
fileprivate struct Vector2D {
    var x = 0.0
    var y = 0.0
}
fileprivate let v1 = Vector2D(x: 2.0, y: 3.0)
fileprivate let v2 = Vector2D(x: 1.0, y: 4.0)
fileprivate let v3 = Vector2D(x: v1.x + v2.x, y: v1.y + v2.y)
// 为了简化 v3 的操作, 我们可以重载 + 操作符
fileprivate func +(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
fileprivate let v4 = v1 + v2

// 接下来, 我们写一个 Vector2D的点积运算

fileprivate func +*(left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}
// 此时编译器报错
// 因为Swift中并没有定义 +* 这个操作符, 我们不能重载
// 需要声明新的操作符
precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}
infix operator +*: DotProductPrecedence

fileprivate let v5 = v1 +* v2


// 对关键字进行解释
/***
    * Precedencegroup
 定义了一个操作符优先级别。操作符优先级的定义和类型声明有些相似，一个操作符比需要属于某个特定的优先级。Swift 标准库中已经定义了一些常用的运算优先级组，比如加法优先级 (AdditionPrecedence) 和乘法优先级 (MultiplicationPrecedence) 等，你可以在这里找到完整的列表。如果没有适合你的运算符的优先级组，你就需要像我们在例子中做得这样，自己指定结合律方式和优先级顺序了。
 
    * associativity
 定义了结合律，即如果多个同类的操作符顺序出现的计算顺序。比如常见的加法和减法都是 left，就是说多个加法同时出现时按照从左往右的顺序计算 (因为加法满足交换律，所以这个顺序无所谓，但是减法的话计算顺序就很重要了)。点乘的结果是一个 Double，不再会和其他点乘结合使用，所以这里是 none；
 
    * higherThan
 运算的优先级，点积运算是优先于乘法运算的。除了 higherThan，也支持使用 lowerThan 来指定优先级低于某个其他组。
 
    * infix
 表示要定义的是一个中位操作符，即前后都是输入；其他的修饰子还包括 prefix 和 postfix，不再赘述；
 
 */
//
// Swift操作符, 不能定义在局部域中
// 有可能来自不同 module 的操作符 发生冲突, 且不容易解决冲突
// 因此, 需要慎重重载或者自定义操作符

import UIKit

class OperatorController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

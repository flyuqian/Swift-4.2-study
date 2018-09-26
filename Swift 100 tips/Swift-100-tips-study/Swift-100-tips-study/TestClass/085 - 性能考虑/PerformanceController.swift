//
//  PerformanceController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 指明某个类型有助于 编译器对性能的优化
//  所以对于性能方面，我们应该注意的地方就很明显了。如果遇到性能敏感和关键的代码部分，我们最好避免使用 Objective-C 和 NSObject 的子类。在以前我们可能会选择使用混编一些 C 或者 C++ 代码来处理这些关键部分，而现在我们多了 Swift 这个选项。相比起 C 或者 C++，Swift 的语言特性上要先进得多，而使用 Swift 类型和标准库进行编码和构建的难度，比起使用 C 或 C++ 来要简单太多。另外，即使不是性能关键部分，我们也应该尽量考虑在没有必要时减少使用 NSObject 和它的子类。如果没有动态特性的需求的话，保持在 Swift 基本类型中会让我们得到更多的性能提升。



import UIKit

class PerformanceController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

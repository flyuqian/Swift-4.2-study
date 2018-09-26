//
//  RatainCountController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 内存自动管理, 释放原则遵循 ARC
// ARC的内存问题: 引用循环
//
// weak 和 unowned
// unowned 会在其引用的对象释放后, 仍引用该无效对象, 尝试访问无效对象, 会造成程序崩溃, 而weak将会将其标记为Optional值
// weak变量必须为Optional 值
// 如果可确定成员在访问期间不被释放, 应使用unowned, 如果有释放的可能, 则需使用weak
// weak常见使用场景
//         设置 delegate
//         self属性存储为闭包时, 其中拥有对self引用时
import UIKit

class RatainCountController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test1()
    }
    
    
    /// 测试引用循环
    func test1() -> Void {
        class A: NSObject {
            let b: B
            override init() {
                b = B()
                super.init()
                b.a = self
            }
            deinit {
                print("A deinit")
            }
        }
        class B: NSObject {
            weak var a: A? = nil
            deinit {
                print("B deinit")
            }
        }
        
        var obj: A? = A()
        obj = nil
        // 运行代码, 此时没有打印 deinit
        // 解决, 一般 被动的一方不要持有主动的一方, 根据上下文, B为被动的一方, 所以将其变量 a 声明为 weak
        // 添加 weak 后, a, b均被释放
    }
}

//
//  FatalErrorController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// @noreturn 表示调用这个方法的话, 可以不需要返回值
import UIKit

class FatalErrorController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // 案例 2
    class MyClass {
        func methodMustBeImplementedInSubClass() {
            fatalError("这个方法必须在子类中被实现")
        }
    }
    class YourClass: MyClass {
        override func methodMustBeImplementedInSubClass() {
            print("your class implementation this method")
        }
    }
    class otherClass: MyClass {
        
    }
    
    
    // 案例 1
    enum MyEnum {
        case Value1, Value2, Value3
    }
    func check(someValue: MyEnum) -> String {
        switch someValue {
        case .Value1:
            return "OK"
        case .Value2: return "maybe OK"
        default:
            fatalError("should not show!")
        }
    }
}

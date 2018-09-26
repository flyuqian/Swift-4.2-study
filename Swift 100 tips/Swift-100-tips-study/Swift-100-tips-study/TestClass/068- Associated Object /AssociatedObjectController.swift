//
//  AssociatedObjectController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// OC 中给类添加成员变量的问题
//  不可以给类添加成员变量
//  使用 property 配合 Associated Object 将一个对象 关联 到已有要拓展的对象上
// 在 Swift中, 两个关联方法依旧有效
import UIKit

class AssociatedObjectController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let a = MyClass()
        printTitle(a)
        
        a.title = "Swift.test"
        printTitle(a)
    }

    
    fileprivate func printTitle(_ input: MyClass) {
        if let title = input.title {
            print("title: \(title)")
        }
        else {
            print("没有设置")
        }
    }
}

fileprivate class MyClass {
    
}

fileprivate var key: Void?

fileprivate extension MyClass {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

//
//  FinalController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// final 用在 class, func, var 前面 进行修饰, 表示不允许对该内佛那个进行集成或者重写操作
// 添加final, 编译器保证这段代码不会被修改, 也代表你认为代码以完备, 没有重写的必要
// 改善性能, 标记final后, 编译器可做出相应的优化
import UIKit

class FinalController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    class Parent {
        final func method() {
            print("配置开始")
            methodImpl()
            print("配置结束")
            
        }
        func methodImpl() {
            fatalError("子类必须实现该方法")
        }
    }
    class Child: Parent {
        override func methodImpl() {
            
        }
    }
}

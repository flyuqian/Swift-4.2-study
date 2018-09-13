//
//  SwiftCollectionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 中常用的原生容器类型有三种: Array, Dictionary, Set
// 他们都是泛型的, 我们在一个集合中只能放同一个类型的元素
//
// 存放不同的类型
// 一
// 将容器中类型声明为 Any/NSObject, 或者一个protocol, 可能会造成部分信息的损失
// 二
// 使用 enum
// 案例

import UIKit

class SwiftCollectionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mixed = [IntOrString.IntValue(1), IntOrString.StringValue("Two"), IntOrString.IntValue(3)]
        for value in mixed {
            switch value {
            case let .IntValue(i):
                print(i * 2)
            case let .StringValue(s):
                print(s.capitalized)
            }
        }
    }
}

fileprivate enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
}

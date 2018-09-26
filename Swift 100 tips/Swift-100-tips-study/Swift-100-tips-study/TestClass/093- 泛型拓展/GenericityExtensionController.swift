//
//  GenericityExtensionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/26.
//  Copyright © 2018 com.test. All rights reserved.
//

//
// 可以使用 extension 为泛型类型添加新的方法
// 类型后面 不可以重新声明泛型的类型
fileprivate extension Array {
    var random: Element? {
        return self.count != 0 ?
            self[Int(arc4random_uniform(UInt32(self.count)))] :
        nil
    }
    
    // 拓展中不能添加整个类型可用的新泛型符号
    // 对于逗哥特定的方法, 我们可以添加 T 以外的其他泛型符号
    func appendRandomDescription<U: CustomStringConvertible>(_ input: U) -> String {
        if let element = self.random {
            return "\(element)" + input.description
        }
        else {
            return "empty array"
        }
    }
}
// 我们不能通过拓展来重新定义已有的泛型符号, 可以对其使用
// 拓展中不能为这个类型添加新的泛型符号, 但只要名字不冲突, 可以在新声明的方法中定义和使用新的泛型符号, 只要名字和原有的不冲突

import UIKit

class GenericityExtensionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let languages = ["Swift", "ObjC", "C++", "Java"]
        print(languages.random ?? "none")
        let ranks = [1, 2, 3, 4]
        ranks.random
        print(languages.appendRandomDescription(ranks.random!))
        
    }

}

//
//  ClosureCyleController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 闭包中对任何其他元素的引用都是会被闭包自动持有
// 在闭包中写self这样的东西的话, 就是闭包持有了当前对象
// 容易形成 self->闭包->self 的引用循环
// 若标记多个元素, 在同一个[]中, 使用,隔开
import UIKit

class ClosureCyleController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }

    
    // 闭包引用循环的例子
    func test() {
        class Person {
            let name: String
            lazy var privateName: () -> () = {
                [weak self] in
                // if let storngSelf = self{}
                // 没有使用 [weak self]修饰, 造成循环引用,  deinit 无法正常打印
                print("This name is \(self?.name)")
            }
            init(personName: String) {
                name = personName
            }
            deinit {
                print("Person deinit \(self.name)")
            }
        }
        
        var xiaoming: Person? = Person(personName: "Xiaoming")
        xiaoming!.privateName()
        xiaoming = nil
    }
}

//
//  OptionalChainingController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Optional Chaining 随时都有可能返回nil, 得到的东西都是Optional的
import UIKit

class OptionalChainingController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    func test() {
        let xiaoming = Child()
        let _ = xiaoming.pet?.toy?.name
        if let _ = xiaoming.pet?.toy?.name { }
        
        xiaoming.pet?.toy?.play()
        let playClosure = {(child: Child) -> () in child.pet?.toy?.play()}
        // playClosure 会得到一个Optional的结果,  如下
        let _ = {(child: Child) -> ()? in child.pet?.toy?.play()}
        // 使用的时候, 我们可以使用Optional Binding 来判断方法是否调用成功
        if let _: () = playClosure(xiaoming) {
            print("好开心")
        }
        else {
            print("没有玩具可以玩")
        }
    }
}

fileprivate class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}
fileprivate class Pet {
    var toy: Toy?
}
fileprivate class Child {
    var pet: Pet?
}
fileprivate extension Toy {
    func play() {
        
    }
}

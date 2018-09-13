//
//  AssociatedypeController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class AssociatedypeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let meat = Meat()
        Tiger().eat(meat)
        isDangerous(animal: Tiger()) // true
        isDangerous(animal: Sheep()) // false

    }
    


}


//
// 案例
/*
fileprivate protocol Food {
    
}
fileprivate protocol Animal {
    func eat(_ food: Food)
}
fileprivate struct Meat: Food {}
fileprivate struct Grass: Food {}

fileprivate struct Tiger: Animal {
    func eat(_ food: Food) {
        if let meat = food as? Meat {
            print("eat \(meat)")
        }
        else {
            fatalError("Tiger can only eat meat")
        }
    }
}
 */
// 上面的代码, 可以实现想要的效果, 但是 没有意义, 只是把责任抛给运行时
//
// 使用 typealias
fileprivate protocol Food {
    
}
fileprivate protocol Animal {
    associatedtype F: Food
    func eat(_ food: F)
}
fileprivate struct Meat: Food {}
fileprivate struct Grass: Food {}

fileprivate struct Tiger: Animal {
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}
fileprivate struct Sheep: Animal {
    typealias F = Grass
    func eat(_ food: Grass) {
        print("eat \(food)")
    }
}
// 此时, 一个遵守了 Animal协议类型的实例, 无法通过 is 判断, 其类型
// 因为, Animal协议包含了一个不确定的类型, 所以Animal也是一个不确定的类型
// 因此, Animal只能当做泛型约束使用, 不能作为独立理性的占位使用, 也失去了动态派发的特性
fileprivate func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}




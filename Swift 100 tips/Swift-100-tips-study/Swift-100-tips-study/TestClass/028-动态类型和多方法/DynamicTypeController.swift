//
//  DynamicTypeController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift中我们可以通过dynamicType获取一个对象的动态类型(运行时类型)
// Swift不支持多方法, 就是不能根据对象在运行时的类型进行合适的重载方法调用

import UIKit

class DynamicTypeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Test().printPet(Test.Pet())
        Test().printPet(Test.Cat())
        Test().printPet(Test.Dog())
    }

}


fileprivate struct Test {
    class Pet {}
    class Cat: Pet { }
    class Dog: Pet { }
    
    func printPet(_ pet: Pet) {
        print("Pet")
    }
    func printPet(_ cat: Cat) {
        print("Cat")
    }
    func printPet(_ dong: Dog) {
        print("Dog")
    }
    func printThem(_ pet: Pet, _ cat: Cat) {
        if let aCat = pet as? Cat {
            
        }
        else if let aDog = pet as? Dog {
            
        }
    }
}

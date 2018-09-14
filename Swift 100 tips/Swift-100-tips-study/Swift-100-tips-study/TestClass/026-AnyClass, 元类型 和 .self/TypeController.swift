//
//  TypeController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

// Swift 中表示 任意 这个概念, 除了 Any和AnyObject外, 还有AnyClass
// Swift 中 AnyClass定义: typealias AnyClass = AnyObject.Type
// 通过 AnyObject.Type的方式, 我们得到的是一个元类型
// 在声明时我们在类型的名称后面加上.Type, 如A.Type表示A这个类型的类型
// 在A中取出其类型时, 需要用到.self
// .self用在类型后面取得类型本身, 用在实例后面获得实例本身
// class, struct, enum 的元类型 .Type,  protocol的元类型 .Protocol

import UIKit

class TypeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeA.method()
    }
    
    
    //
    // 1
    class A {
        class func method() { print("hello") }
    }
    let typeA: A.Type = A.self
    // typeA.method()
    
    //
    // 2
    class MusicViewController: UIViewController {
        
    }
    class AlbumViewController: UIViewController {
        
    }
    let usingVCTypes: [AnyClass] = [MusicViewController.self, AlbumViewController.self]
    func setupViewcontrollers(_ vcTypes: [AnyClass]) {
        for vcType in vcTypes {
            if vcType is UIViewController.Type {
                let vc = (vcType as! UIViewController.Type).init()
                print(vc)
            }
        }
    }
}

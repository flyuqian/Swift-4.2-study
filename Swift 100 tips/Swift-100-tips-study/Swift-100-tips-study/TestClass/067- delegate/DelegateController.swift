//
//  DelegateController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 在 Swift 中, 因为 protocol 可以被class,struct,enum 实现, 所以设置代理时, 不能标记为 weak, 所以当x声明protocol为delegate时, 需要声明为@objc, 确保该协议只会被OC类 实现, 也可以声明protocol 继承自class, 确保只有class能实现
// 使用 class 限定 protocol 相比于 @objc 更加Swift, 摆脱OC
import UIKit

class DelegateController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


    func testDelegate() {
        class UseDelegate: MyClassDelegate {
            
            func method() {
                print("using delegate method")
            }
            
            var somInstance: MyClass?
            
            func test() -> Void {
                
            }
            
            init() {
                somInstance = MyClass()
                somInstance?.delegate = self
            }
        }
    }

}

fileprivate protocol MyClassDelegate: class {
    func method()
}
fileprivate class MyClass {
    weak var delegate: MyClassDelegate?
    
    func some() {
        if let delegate = delegate {
            delegate.method()
        }
    }
}

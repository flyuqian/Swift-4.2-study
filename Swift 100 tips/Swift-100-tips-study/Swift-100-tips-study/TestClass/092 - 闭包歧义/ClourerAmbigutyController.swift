//
//  ClourerAmbigutyController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/26.
//  Copyright © 2018 com.test. All rights reserved.
//

//
// Swift 的闭包有很多写法, 但是最正规的应该是完整的将必报的输入和输出都写上, 然后用 in 隔离参数和实现, 如下边的 times
//
import UIKit

class ClourerAmbigutyController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        // 完整写法
        3.times { (i: Int) -> () in
            print(i)
        }
        // 简写
        3.times { i in
            print(i)
        }
        
        3.times {
            // print("call ...")
        }
        3.times { (x, y) in
            print("x: \(x), y: \(y)")
        }
        // 下边这种编译不通过
//        3.times { i: (Int, Int) in
//            print(i)
//        }
    }
    

    


}
fileprivate extension Int {
    func times(f: (Int) -> ()) {
        print("Int")
        for i in 1...self {
            f(i)
        }
    }
    
    func times(f: () -> ()) {
        print("Void")
        for _ in 1...self {
            f()
        }
    }
    func times(f: (Int, Int) -> ()) {
        print("Tuple")
        for i in 1...self {
            f(i, i)
        }
    }
}

//
//  MutatingController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// protocol 可以被 class struct enum 实现
// struct/enum 方法若想修改其变量, 需要在将方法声明为mutating
import UIKit

class MutatingController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// 如将mutating去掉, 编译器-报错提示
protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor { get set }
    
    mutating func changeColor()
}

struct MyCar: Vehicle {
    var numberOfWheels: Int = 4
    
    var color: UIColor = .blue
    
    mutating func changeColor() {
        color = .red
    }
}

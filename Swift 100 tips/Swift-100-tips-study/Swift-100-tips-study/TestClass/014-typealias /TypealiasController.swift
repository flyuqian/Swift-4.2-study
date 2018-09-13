//
//  TypealiasController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

// typealias
// typealias 是用来为已经存在的类型重新打定义名字
// typealias 语句使用想普通的赋值语句一样

import UIKit

class TypealiasController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // 案例1
    // 可是代码表述更加清晰
    func test1() -> Void {
        typealias Location = CGPoint
        typealias Distance = Double
        
        func distance(from location: Location, to anotherLocation: Location) -> Distance {
            let dx = Distance(location.x - anotherLocation.x)
            let dy = Distance(location.y - anotherLocation.y)
            return sqrt(dx * dx + dy * dy)
        }
        let origin: Location = Location(x: 0, y: 0)
        let point = Location(x: 1, y: 1)
        let d: Distance = distance(from: origin, to: point)
    }
    
    //
    // typealias是单一的, 你必须指定特定的类型通过 typealias赋值为新名字, 不能为整个泛型类型进行重命名
    class Person<T>{}
    // 错误形式
    // typealias Worker = Person      ___并未报错
    // typealias Worker = Person<T>
    // 正确方式
    typealias Worker<T> = Person<T>
    
    // & 组合协议
    fileprivate typealias Pet = Cat & Dog
}
fileprivate protocol Cat { }
fileprivate protocol Dog { }


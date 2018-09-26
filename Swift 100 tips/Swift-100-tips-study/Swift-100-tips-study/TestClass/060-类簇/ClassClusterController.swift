//
//  ClassClusterController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/20.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 类簇, 使用同一的公共的类来定制单一的接口, 然后在表面之下对应若干个私有类进行实现 的方式, 可以避免公开众多子类造成混乱

import UIKit

class ClassClusterController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    // 类簇 的实现
    
    class Drinking {
        typealias LiquidColor = UIColor
        var color: LiquidColor {
            return .clear
        }
        
        class func drinking(name: String) -> Drinking {
            var drinking: Drinking
            switch name {
            case "Coke":
                drinking = Coke()
            case "Beer":
                drinking = Beer()
            default:
                drinking = Drinking()
            }
            return drinking
        }
    }
    
    class Coke: Drinking {
        override var color: ClassClusterController.Drinking.LiquidColor {
            return .black
        }
    }
    
    class Beer: Drinking {
        override var color: ClassClusterController.Drinking.LiquidColor {
            return .yellow
        }
    }
}

//
//  TFInfunc03Controller.swift
//  TF01
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFInfunc03Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "柯里化"
        view.backgroundColor = .white
    }
    
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    // 柯里化
    func adder(adder: Int) -> (Int) -> Int {
        return { number in
            return adder + number
        }
    }

    

}

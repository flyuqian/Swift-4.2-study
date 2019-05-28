//
//  TPK4.swift
//  TestPromiss
//
//  Created by IOS3 on 2019/5/10.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import PromiseKit
import PMKFoundation


class TPK4: UIViewController {
    
    @objc dynamic var message = "hangge.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "URLSession 扩展"
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TPK4.changeMessage), userInfo: nil, repeats: true)
        observeMessage()
    }
    
   
    @objc func changeMessage() -> () {
        self.message.append("!")
    }
    
    func observeMessage() -> Void {
        self.observe(.promise, keyPath: #keyPath(TPK4.message)).done { value in
            print(value ?? "")
            self.observeMessage()
        }
    }
    
}

fileprivate typealias Doc = TPK2
fileprivate typealias Test = TPK2


fileprivate extension Doc {
    
}

fileprivate extension Test {

}

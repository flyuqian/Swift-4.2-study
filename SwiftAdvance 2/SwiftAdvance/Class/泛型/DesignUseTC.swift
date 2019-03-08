//
//  DesignUseTC.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2019/2/27.
//  Copyright © 2019 com.test. All rights reserved.
//

import UIKit

class DesignUseTC: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    // 这里, 对一段代码进行重构, 使用泛型提取出共通的风能, 减少模板代码
    
    struct User {
        
    }
    func loadUsers(callback: ([User]?) -> ()) {
//        var webserviceURL = "http:\\..."
//        let usersURL = webserviceURL.appending
    }

}



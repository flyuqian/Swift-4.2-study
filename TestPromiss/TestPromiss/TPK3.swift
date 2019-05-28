//
//  TPK3.swift
//  TestPromiss
//
//  Created by IOS3 on 2019/5/9.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit


fileprivate class MyObserver: NSObject {
    var name: String = ""
    init(name: String) {
        super.init()
        self.name = name
        beginObserver()
    }
    
    func beginObserver() {
        let notificationName = Notification.Name(rawValue: "DownloadImageNotification")
        NotificationCenter.default.observe(once: notificationName).done { notification in
            let userInfo = notification.userInfo as! [String : AnyObject]
            let value1 = userInfo["value1"] as! String
            let value2 = userInfo["value2"] as! Int
            
            print("\(self.name) 获取到通知, 用户数据是 [\(value1), \(value2)]")
            sleep(3)
            print("\(self.name) 执行完毕")
            self.beginObserver()
        }
    }
}


class TPK3: UIViewController {
    
    fileprivate let observers = [MyObserver(name: "观察器1"), MyObserver(name: "观察器2")]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "NotificationCenter 扩展"
        
//        beginObserver()
        
        testMyObserver()
        
    }
    
    
}

fileprivate typealias Doc = TPK3
fileprivate typealias Test = TPK3


fileprivate extension Doc {
    // UIApplication.didEnterBackgroundNotification
    // IResponder.keyboardWillShowNotification
    // UIResponder.keyboardWillHideNotification
}

fileprivate extension Test {
    func beginObserver() {
        NotificationCenter.default.observe(once:
            UIApplication.didEnterBackgroundNotification)
            .done { (notification) in
                print("程序进入后台")
                // 接续监听
                self.beginObserver()
        }
    }
    
    
    
    func testMyObserver() {
        print("发出通知")
        let notificationName = Notification.Name("DownloadImageNotification")
        NotificationCenter.default.post(name: notificationName, object: self,
                                        userInfo: ["value1" : "hangge.com", "value2" : 12345])
        print("通知发送完毕")
    }
    
}

//
//  DebugRxController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift


class DebugRxController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // debug
        // 我们可以将 debug 调试操作添加到一个链式步骤当中这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试。
        

        
        
        Observable.of("2", "3")
            .debug()
            .startWith("1")
            .debug("调试")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // RxSwift.Resources.total
        // 查看当前 RxSwift 申请的所有资源数量
        
        //        print(RxSwift.Resources.total)
        // 自己使用报错, 以后再试

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FYRequestHUDPlugin.swift
//  TestMoya
//
//  Created by IOS3 on 2019/4/1.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import Moya
import Result


final class FYRequestHUDPlugin: PluginType {
    
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        viewController.view.showWait("加载中...")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        MBProgressHUD.hide(for: viewController.view, animated: true)
    }
}



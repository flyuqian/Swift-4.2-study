//
//  TestMBP_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TestMBP_2_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
    }
    
    
    
    func test1() {
        
//        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud.label.text = "请稍后"
        // 设置 遮罩为半透明黑色
//         hud.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
//        hud.backgroundView.style = .blur
        
        // 设置提示框
//        hud.bezelView.color = .clear
//        hud.bezelView.layer.cornerRadius = 20

        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "请稍等"
        hud.detailsLabel.text = "安静的抗打击咖喱"
        hud.label.textColor = .orange
        hud.label.font = UIFont.systemFont(ofSize: 20)
        hud.detailsLabel.textColor = .blue
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 11)
        
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = .red
        
        // 边框 与 内容 距离
        hud.margin = 10
        
        // minSize 最小尺寸
        // isSquare 是正方形提示框
        
        // 自定义样式
        // .mode = .customView
        // hud.customView = UIImageView(image: ...
        // hud.label.text = ""

    }

   

}

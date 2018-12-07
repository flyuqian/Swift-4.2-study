//
//  TestMBP_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit


class TestMBP_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    

    @objc func hudTaped() {
        print("HUD taped ... ")
    }
    

    
    func test2() {
        // test1()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 立即 隐藏 HUD 窗口
        // hud.hide(animated: true)
        
        // 延时隐藏
        // hud.hide(animated: true, afterDelay: 1)
        
        // 最小 需要多少时间才隐藏
        //        hud.minShowTime = 2
        //        hud.hide(animated: true)
        
        
        // 消失动画
        /*
         .fade：逐渐透明消失（默认值）
         .zoomOut：逐渐缩小并透明消失
         .zoomIn：逐渐放大并透明消失
         */
        
        //        hud.label.text = "请稍等"
        //        hud.removeFromSuperViewOnHide = true // 隐藏时从父视图移除
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hudTaped))
        hud.addGestureRecognizer(tap)
    }
    
    func test1() {
        // 转圈
        // _ = MBProgressHUD.showAdded(to: view, animated: true)
        
        // 文字
        //        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        //        hud.mode = .text
        //        hud.label.text = "请稍等"
        //        hud.detailsLabel.text = "具体要等多久我不知道"
        
        
        // 默认 文字加圈
        //        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        //        hud.label.text = "请稍等"
        //        hud.detailsLabel.text = "具体要等多久我也不知道"
        
        // 带进度条
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // hud.mode = .determinateHorizontalBar // 显示水平进度条
        hud.mode = .annularDeterminate  // 环形进度条
        hud.progress = 0.3
        hud.label.text = "当前进度: %30"

    }
}

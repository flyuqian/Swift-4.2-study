//
//  TraitsSequence3Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/20.
//  Copyright © 2018 IOS3. All rights reserved.
//
// 本小节有 UIViewController+Rx.swift
// 为 UIController 的生命周期添加 RxSwift 拓展

import UIKit

class TraitsSequence3Controller: BaseController {

    
    // MARK: ControlProperty
    // 专门用来描述 UI 控件的属性, 拥有该类型的属性都是被观察者
    // 特征
        /*  不会产生 error 事件
            一定在 MainScheduler 订阅（主线程订阅）
            一定在 MainScheduler 监听（主线程监听）
            共享状态变化 */
    // RxCocoa下许多UI控件属性都是被观察者
    // 比如我们查看源码（UITextField+Rx.swift），可以发现 UITextField 的 rx.text 属性类型便是 ControlProperty<String?>：
    func test1() {
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 160, width: 300, height: 50))
        view.addSubview(textField)
        view.addSubview(label)
        textField.backgroundColor = .gray
        label.backgroundColor = .gray
        
        textField.rx.text
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    
    // MARK: ControlEvent
    // ControlEvent 专门用来描述UI所产生的事件, 拥有该类型的属性都是被观察者
    // 特征, 与ControlProperty相同
    func test2() {
//        button.rx.tap
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        
    }
    

    

}

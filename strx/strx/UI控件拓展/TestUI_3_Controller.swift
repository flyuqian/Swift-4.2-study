//
//  TestUI_3_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/21.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TestUI_3_Controller: BaseController {
    
    
    //MARK: UIButton UIBarButtonItem
    // UIButton 的点击相应
    // button.rx.tap.subscrib(onNext: {})
    // button.rx.tap.bind {}
    // timer.map{"计数\($0)"}.bind(to: button.rx.title(for: .normal))
    // .bind(to: button.rx.attributedTitle())
    // .bind(to: button.rx.image())
    // .bind(to: button.rx.backgroundImage())
    // .bind(to: button1.rx.isEnabled)
    
    //MARK: UISwitch UISegmentedControl
    // switch.rx.isOn.asObservable/bind
    // segmented.rx.selectedSegmentIndex.asObservable()
    
    //MARK: UIActivityIndicatorView 与 UIApplication
    /* 显示网络状态
     
     mySwitch.rx.value
     .bind(to: activityIndicator.rx.isAnimating)
     .disposed(by: disposeBag)
     
     mySwitch.rx.value
     .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
     .disposed(by: disposeBag)
     */
    
    //MARK: UISlider、UIStepper
    /*
     UISlider（滑块
     slider.rx.value.asObservable()
         .subscribe(onNext: {
            print("当前值为：\($0)")
         })
         .disposed(by: disposeBag)
     
     UIStepper（步进器）
     stepper.rx.value.asObservable()
         .subscribe(onNext: {
            print("当前值为：\($0)")
         })
         .disposed(by: disposeBag)
     */
    
    //MARK: UIGestureRecognizer
    /*
     let swipe = UISwipeGestureRecognizer()
     swipe.direction = .up
     self.view.addGestureRecognizer(swipe)
     
     //手势响应
     swipe.rx.event
         .subscribe(onNext: { [weak self] recognizer in
             //这个点是滑动的起点
             let point = recognizer.location(in: recognizer.view)
             self?.showAlert(title: "向上划动", message: "\(point.x) \(point.y)")
         })
         .disposed(by: disposeBag)
     
     swipe.rx.event
         .bind { [weak self] recognizer in
             //这个点是滑动的起点
             let point = recognizer.location(in: recognizer.view)
             self?.showAlert(title: "向上划动", message: "\(point.x) \(point.y)")
         }
         .disposed(by: disposeBag)
     */
    
    
    //MARK: DatePicker
    /*
     datePicker.rx.date
         .map { [weak self] in
            "当前选择时间: " + self!.dateFormatter.string(from: $0)
         }
         .bind(to: label.rx.text)
         .disposed(by: disposeBag)
     */

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    

}

//
//  BothwayBindingController.swift
//  strx
//
//  Created by IOS3 on 2018/11/21.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class BothwayBindingController: BaseController {

    
    // test1 简单的双向绑定
    /*
     （1）页面上方是一个文本输入框，用于填写用户名。它与 VM 里的 username 属性做双向绑定。
     （2）下方的文本标签会根据用户名显示对应的用户信息。（只有 hangge 显示管理员，其它都是访客）
     */
    func test1() {
        struct UserViewModel {
//             let username = Variable("guest")
            let username = BehaviorRelay(value: "guest")
            
            lazy var userinfo = {
                return self.username.asObservable()
                    .map { $0 == "hangge" ? "您是管理员" : "你是普通访客" }
                    .share(replay: 1, scope: .forever)
            }()
        }
        
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        textField.backgroundColor = .gray
        view.addSubview(textField)
        
        let label = UILabel(frame: CGRect(x: 0, y: 150, width: 300, height: 40))
        label.backgroundColor = .gray
        view.addSubview(label)
        
        var userVM = UserViewModel()
        
        //
        // userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        // textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        
        // 使用 RxExample 中 Operators中 定义的双向绑定
        _ = textField.rx.textInput <-> userVM.username
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        
    }
    
    
    func test2() {
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        textField.backgroundColor = .gray
        view.addSubview(textField)
        
        let textField2 = UITextField(frame: CGRect(x: 0, y: 150, width: 300, height: 40))
        textField2.backgroundColor = .gray
        view.addSubview(textField2)
        
//        _ = textField.rx.textInput <-> textField2.rx.textInput
    }
    
    
    
    
    //MARK: 双向绑定和DatePicker 练习
    func test3() {
        
        let ctimer = UIDatePicker(frame:CGRect(x:0, y:80, width:320, height:200))
        ctimer.datePickerMode = .countDownTimer
        self.view.addSubview(ctimer)
        
        let btnstart =  UIButton(type: .system)
        btnstart.frame = CGRect(x:0, y:300, width:320, height:30);
        btnstart.setTitleColor(UIColor.red, for: .normal)
        btnstart.setTitleColor(UIColor.darkGray, for:.disabled)
        self.view.addSubview(btnstart)
        
        
        
        // 剩余时间 (必须为 60倍数, 比如设置为100,自动变为60)
        let leftTime = BehaviorRelay(value: TimeInterval(180)) //Variable(TimeInterval(180))
        // 记录倒计时是否结束
        let countDownStopped = BehaviorRelay(value: true) //Variable(true)
        
        DispatchQueue.main.async {
            _ = ctimer.rx.countDownDuration <-> leftTime
        }
        
        // 绑定button标题
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()) {
            leftTimeValue, coundtDownStoppedValue in
            if coundtDownStoppedValue {
                return "开始"
            }
            else {
                return "倒计时开始，还有 \(Int(leftTimeValue)) 秒..."
            }
            }.bind(to: btnstart.rx.title())
            .disposed(by: disposeBag)
        
        countDownStopped.asDriver().drive(ctimer.rx.isEnabled).disposed(by: disposeBag)
        countDownStopped.asDriver().drive(btnstart.rx.isEnabled).disposed(by: disposeBag)
        
        btnstart.rx.tap
            .bind { [weak self] in
                countDownStopped.accept(false)
                Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                    .takeUntil(countDownStopped.asObservable().filter { $0 })
                    .subscribe { event in
                        leftTime.accept(leftTime.value - 1)
                        if leftTime.value == 0 {
                            print("倒计时结束")
                            countDownStopped.accept(true)
                            leftTime.accept(180)
                        }
                    }.disposed(by: self!.disposeBag)
            }.disposed(by: disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test1()
//        test2()
        test3()
        
        
    }
    

    

}

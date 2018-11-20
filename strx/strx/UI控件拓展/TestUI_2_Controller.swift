//
//  TestUI_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestUI_2_Controller: BaseController {

    
    
    func test1() {
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        textField.backgroundColor = .gray
        view.addSubview(textField)
        
        // 下面 效果一样
        // textField.rx.text.orEmpty.asObservable()
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    func test2() {
        // Throttling 是 RxSwift 的一个特性。因为有时当一些东西改变时，通常会做大量的逻辑操作。而使用 Throttling 特性，不会产生大量的逻辑操作，而是以一个小的合理的幅度去执行。比如做一些实时搜索功能时，这个特性很有用。
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        textField.backgroundColor = .gray
        view.addSubview(textField)
        
        let textField2 = UITextField(frame: CGRect(x: 0, y: 150, width: 300, height: 40))
        textField2.backgroundColor = .gray
        view.addSubview(textField2)
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 40))
        view.addSubview(label)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 250, width: 200, height: 40))
        btn.setTitle("提交", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        view.addSubview(btn)
        btn.rx.tap.asObservable()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // 转换为Driver, 0.3s内若多次改变, 取最后一次操作
        let input = textField.rx.text.orEmpty.asDriver().throttle(0.3)
        input.drive(textField2.rx.text).disposed(by: disposeBag)
        input.map { "当前字数: \($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        input.map { $0.count > 5 }
            .drive(btn.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
   
    // 监听多个 TextField 内容变化
    func test3() {
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        textField.backgroundColor = .gray
        view.addSubview(textField)
        
        let textField2 = UITextField(frame: CGRect(x: 0, y: 150, width: 300, height: 40))
        textField2.backgroundColor = .gray
        view.addSubview(textField2)
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 40))
        view.addSubview(label)
        
        Observable.combineLatest(textField.rx.text.orEmpty, textField2.rx.text.orEmpty) {
            value1, value2 -> String in
            return "\(value1) : \(value2)"
            }.map { $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    
    // 事件监听
    /*
     通过 rx.controlEvent 可以监听输入框的各种事件，且多个事件状态可以自由组合。除了各种 UI 控件都有的 touch 事件外，输入框还有如下几个独有的事件：
     editingDidBegin：开始编辑（开始输入内容）
     editingChanged：输入内容发生改变
     editingDidEnd：结束编辑
     editingDidEndOnExit：按下 return 键结束编辑
     allEditingEvents：包含前面的所有编辑相关事件
     */
    func test4() {
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        textField.backgroundColor = .gray
        view.addSubview(textField)
        
        let textField2 = UITextField(frame: CGRect(x: 0, y: 150, width: 300, height: 40))
        textField2.backgroundColor = .gray
        view.addSubview(textField2)
        
        textField.rx.controlEvent([.editingDidBegin]) // 状态可以组合
            .asObservable()
            .subscribe(onNext: { print("开始编辑b内容") })
            .disposed(by: disposeBag)
    }
    
    /*
     UITextView 还封装了如下几个委托回调方法：
     didBeginEditing：开始编辑
     didEndEditing：结束编辑
     didChange：编辑内容发生改变
     didChangeSelection：选中部分发生变化
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
//        test2()
//        test3()
        test4()
    }
    

    

}

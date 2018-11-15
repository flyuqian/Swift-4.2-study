//
//  Observer2Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/15.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Observer2Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
    }
    
}


// 通过UI类进行扩展
fileprivate extension UILabel {
    var fontSize: Binder<CGFloat> {
        return Binder(self, binding: { (lable, fontSize) in
            lable.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
}
// 通过对 Reactive 进行拓展
fileprivate extension Reactive where Base: UILabel {
    var fontSize: Binder<CGFloat>{
        return Binder(self.base, binding: { (lable, fontSize) in
            lable.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
}
extension Observer2Controller {
    func test1() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100));
        label.text = "添"
        view.addSubview(label)
        
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        
        observable
            .map { CGFloat($0) }
//            .bind(to: label.fontSize)   //通过UI 扩展
            .bind(to: label.rx.fontSize)  // 通过 reactive扩展
            .disposed(by: disposeBag)
    }
}



// RxSwift 的自带一些绑定熟悉感 (UI观察者)
// 如: label 的text 和 attributedText
extension Observer2Controller {
    func test2() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100));
        view.addSubview(label)
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引: \($0)" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}




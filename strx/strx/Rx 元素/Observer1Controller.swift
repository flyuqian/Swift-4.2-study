//
//  Observer1Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/15.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Observer1Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test2()
//        test3()
//        test4()
        test5()
        
    }

}

//MARK: -观察者介绍
// 观察者: Observer, 其作用就是监听事件, 然后对这个时间作出相应, 或者说任何响应时间的行为都是观察者

//MARK: 在 subscribe / bind 方法中创建观察者
extension Observer1Controller {
    
    func test1() {
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(onNext: {element in
            print(element)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        // 观察者就由这些 onNext, onError, onCompleted 闭包构件出来的
    }
    
    // 在bind 方法中创建
    func test2() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
        view.addSubview(label)
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引: \($0)" }
            .bind { (text) in
                label.text = text;
            }.disposed(by: disposeBag)
    }
}


//MARK: 使用AnyObserver 创建观察者
// AnyOnserver 可以用来描述任意一种观察者
extension Observer1Controller {
    
    func test3() {
        let observable = Observable.of("A", "B", "C")
        
        let observer: AnyObserver<String> = AnyObserver { event in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        observable.subscribe(observer)
            .disposed(by: disposeBag)
    }
    
    // 配合 bind使用
    func test4() {
        
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100));
        view.addSubview(label)
        
        let observer: AnyObserver<String> = AnyObserver { event in
            switch event {
            case .next(let text):
                label.text = text;
            default:
                break
            }
        }
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引: \($0)" }
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
}


//MARK: 使用 Binder 创建观察者
// Binder 有两个特征
//  1. 不会处理错误事件, 一旦产生错误事件, debug下执行fataError, release打印错误信息
//  2. 确保绑定都是在给定的Scheduler上执行, 默认 MainScheduler
extension Observer1Controller {
    
    func test5() {
     
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100));
        view.addSubview(label)
        
        let observer: Binder<String> = Binder(label) { view, text in
            view.text = text
        }
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引: \($0)" }
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
}

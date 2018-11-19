//
//  MathOperatorsController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift


class MathOperatorsController: BaseController {

    
    // MARK: toArray
    // 该操作符, 把一个序列转成一个数组, 并作为一个单一的事件发送
    func testToArray() {
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    //MARK: reduce
    // 接受一个初始值, 和一个操作符
    // 初始值 与序列里的每个值进行累计运算, 得到一个最终值, 并将最终值发送出去
    func testReduce() {
        Observable.of(1, 2, 3, 4, 5)
            .reduce(0, accumulator: +) { /* "\($0)" */ $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: concat
    // concat 会把多个Observable序列合并(串联)成一个 Observable 序列
    // 并且只有当前面一个 Observable 序列发送出 completed事件, 才会开始发送下一个 Observable 序列事件
    func testConcat() {
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        
        variable.value = subject2
        subject2.onNext(2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        testToArray()
//        testReduce()
        testConcat()
    }
    

    

}

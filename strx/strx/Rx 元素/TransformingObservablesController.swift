//
//  TransformingObservablesController.swift
//  strx
//
//  Created by IOS3 on 2018/11/16.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift

class TransformingObservablesController: BaseController {

   
    

    // MARK: buffer
    // 作用: 缓冲组合, 参数: 缓冲时间, 缓冲个数, 缓冲线程
    // 就是: 缓存Observable发出的元素, 当元素达到某个数量或者特定时间, 就将这个元素集合发送出来
    func testBuffer() {
        let subject = PublishSubject<String>()
        subject
            .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    
    // MARK: window
    // window与buffer相似, 不过window是周期性的将元素集合以Observable的形态发送出来
    func testWindow() {
        let subject = PublishSubject<String>()
        subject
            .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                print($0)
                $0.asObservable()
                    .subscribe(onNext: { print($0) })
                    .disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }

    
    
    // MARK: map
    // 该操作符通过传入一个函数闭包把原来的Observable序列转变为一个新的Observable序列
    func testMap() {
        Observable.of(1, 2, 3)
            .map { $0 * 10 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: flatMap
    // map 在转换的时候容易出现升维的情况, 即 从一个序列变成一个序列的序列
    // flatMap 将意外的升维降为, 发送一个Observable序列
    
    // flatMapLatest
    // 与 flatMap 的唯一区别是：flatMapLatest 只会接收最新的 value 事件
    
    // flatMapFirst
    // 与 flatMapLatest 正好相反：flatMapFirst 只会接收最初的 value 事件。
    func testFlatMap() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        variable.asObservable()
//            .map { $0 }
//            .flatMap { $0 }
//            .flatMapLatest { $0 }
            .flatMapFirst { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
    }
    
    
    
    // MARK: concatMap
    // concatMap 与 flatMap 的唯一区别是: 当一个Observable元素发送完毕后, 后一个Observable才可以开始发出元素, 或者说等待前一个Observable产生事件完成后, 才能对后一个Observable 订阅
    func testConcatMap() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .concatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
        subject1.onCompleted()
    }
    
    
    
    
    //MARK: scan
    // 先给一个初始化的书, 然后不断拿前一个结果和最新的值进行处理操作
    func testScan() {
        Observable.of(1, 2, 3, 4, 5)
            .scan(0) { (acum, elem) in
                acum + elem
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: groupBy
    // 将Observable 分解为多个子Observable, 然后将这些子Observable发送出来
    func testGroupby() {
        Observable.of(0, 1, 2, 3, 4, 5)
            .groupBy { (element) -> String in
                return element % 2 == 0 ? "偶数" : "奇数"
            }
            .subscribe { event in
                switch event {
                case .next(let group):
                    group.asObservable().subscribe { event in
                        print("Key: \(group.key) event: \(event)")
                        }
                        .disposed(by: self.disposeBag)
                default:
                    print("")
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testBuffer()
//        testWindow()
//        testMap()
//        testFlatMap()
//        testConcatMap()
//        testScan()
        testGroupby()
    }
}

//
//  SubjectsViewController.swift
//  strx
//
//  Created by IOS3 on 2018/11/16.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift

class SubjectsViewController: BaseController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        testBehaviorSubject()
//        testReplaySubject()
        testVariable()
    }
    
    
    // MARK: Subjects
    // 创建 Observable 的时候需要预先将数据准备好, 等到有人订阅的时候将Event 发出去
    // 当我们期望Observable在运行时动态产生数据, 并通过Event发出, 可以通过Subject实现
    
    // 基本介绍
    // Subjects 是订阅者也是Observable
    // Subjects 可以分为四类, PublishSubject BehaviorSubjects, ReplaySubject, Variable
    // 特点: 是Observable,可发出Event, 符合Observable结束的条件, 对于订阅已经结束的Subjects, 订阅者可接收到Subjects的结束信息
    // 几个Subjects的区别是当一个订阅者订阅的时候能不能受到 订阅前该Subjects的事件, 能接收到多少
    // Subject 常用方法, onNext(:) 是on(.next(:))的缩写, 还有 onError(:), onCompleted(:)

    // MARK: PublishSubject
    // 特点, 不需要初识值就能创建, 订阅者可以收到 订阅后Subjects发出的事件
    func testPublishSubject() {
        
        let disposeBag = DisposeBag()
        
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
        
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
        
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
        //让subject结束
        subject.onCompleted()
        //subject完成后会发出.next事件了。
        subject.onNext("444")
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
    }
    
    
    //MARK: BehaviorSubject
    // 通过一个默认值创建
    // 当订阅者来订阅它的时候, 这个订阅者会立即收到 BehaviorSubject 上一个发出的Event, 之后与PublisSubject相同
    func testBehaviorSubject() {
        let subject = BehaviorSubject(value: "111")
        subject.subscribe { event in
            print("第一次订阅: ", event);
        }.disposed(by: disposeBag)
        
        subject.onNext("222")
        
        
        subject.subscribe { event in
            print("第二次订阅: ", event)
        }.disposed(by: disposeBag)
        
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
    }
    
    
    //MARK: ReplaySubject
    // 创建的时候需要设置一个 bufferSize, 表示对它发送过的event缓存个数
    // 订阅者订阅 ReplaySubject 后, 会先收到Subject缓存的event, 如果ReplaySubject已经结束, 则会收到缓存Event和结束event
    func testReplaySubject() {
        let disposeBag = DisposeBag()

        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)

        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")

        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
            }.disposed(by: disposeBag)

        //再发送1个next事件
        subject.onNext("444")

        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
            }.disposed(by: disposeBag)

        //让subject结束
        subject.onCompleted()

        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
            }.disposed(by: disposeBag)
    }
    

    
    //MARK:  Variable
    // 对 BehaviorSubject的封装, 必须通过一个默认的初始值创建
    // 能向订阅者发出上一个以及之后的event
    // Variable有一个value属性, 给value设值就相当于Subjects调用onNext()方法
    // Variable没有subscribe方法, 通过Subjects的公有方法 asObservable, 返回一个可订阅的Observable
    func testVariable() {
        //创建一个初始值为111的Variable
        let variable = Variable("111")
        
        //修改value值
        variable.value = "222"
        
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "333"
        
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "444"
    }
    
    
    // BehaviorRelay
    // BehabiorRelay 作为Variable的替代者出现, 通过初始值创建, 订阅者可接收上一个event
    // 不需要手动通过completed或error结束
    // 具有value属性, 通过accept()修改
    func testBehaviorRelay() {
        //创建一个初始值为111的BehaviorRelay
//
//        let subject = BehaviorRelay<String>(value: "111")
//
//        //修改value值
//        subject.accept("222")
//
//        //第1次订阅
//        subject.asObservable().subscribe {
//            print("第1次订阅：", $0)
//            }.disposed(by: disposeBag)
//
//        //修改value值
//        subject.accept("333")
//
//        //第2次订阅
//        subject.asObservable().subscribe {
//            print("第2次订阅：", $0)
//            }.disposed(by: disposeBag)
//
//        //修改value值
//        subject.accept("444")
    }
    
    
}

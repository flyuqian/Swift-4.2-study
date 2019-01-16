//
//  TestPromise_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import PromiseKit


class TestPromise_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test01()
    }
    

}


// MARK: PromiseKit
// 一个用来处理异步编程的框架
extension TestPromise_1_Controller {
    
    // then(). done()
    // 简单来讲，then 方法就是把原来的回调写法分离出来，在异步操作执行完后，用链式调用的方式执行回调函数。
    // 而 Promise 的优势就在于这个链式调用。我们可以在 then 方法中继续写 Promise 对象并返回，然后继续调用 then 来进行回调操作。
    // 不同于 then() 方法需要输入一个 promise 值并返回一个 promise，done() 方法可以输入一个 promise 值并返回一个空的 promise。因此我们会在整个链式调用的末尾使用 done() 方法做终结。
    func test01() {
        
        // 做饭
        func cook() -> Promise<String> {
            print("开始做饭")
            let p = Promise<String> { resolver in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    print("做饭完毕")
                    resolver.fulfill("鸡蛋炒饭")
                })
            }
            return p
        }
        // 吃饭
        func eat(data: String) -> Promise<String> {
            print("开始吃法: " + data)
            let p = Promise<String> { resolver in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    print("吃饭完毕")
                    resolver.fulfill("一块碗和一双筷子")
                })
            }
            return p
        }
        // 洗碗
        func wash(data: String) -> Promise<String> {
            print("开始洗碗 " + data)
            let p = Promise<String> {
                resolver in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    print("洗碗完毕")
                    resolver.fulfill("干净的碗")
                })
            }
            return p
        }
        
//        // 使用
//        _ = cook()
//            .then { data -> Promise<String> in
//                return eat(data: data)
//            }.then { data -> Promise<String> in
//                return wash(data: data)
//            }.done { data in
//                print(data)
//            }
//        // 或者
//        _ = cook()
//            .then(eat)
//            .then(wash)
//            .done { data in
//                print(data)
//            }
        
        // 上面的例子, fullfill 方法把Promise的状态设置为完成状态(fullfilled), 这时then方法就能捕捉到变化, 并执行成功情况的回调
        // 而 reject 方法就是把 Promise 的状态置为已失败rejected, 这时就能进到 catch方法中, 我们再次处理错误
        // finally() 方法, 执行完then或者catch后, 执行finally方法
        
        // 写一个 抛出错误的cook
        func cook2() -> Promise<String> {
            print("开始做饭")
            let p = Promise<String> {
                resolver in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    print("做饭失败")
                    let error = NSError(domain: "PromiseKitTutorial", code: 0, userInfo: [NSLocalizedDescriptionKey : "烧焦的饭"])
                    resolver.reject(error)
                })
            }
            return p
        }
//        _ = cook2()
//            .then(eat)
//            .done { data in
//                print(data)
//            }.catch { error in
//                print(error.localizedDescription + "没法吃!")
//            }.finally {
//                print("出门上班")
//        }

        // then方法要求输入一个 Promise值, 并返回一个promise值, map是根据先前的promise的结果, 返回一个新的对象或值类型
        // compactMap()与map类似, 不过它返回的Optional, 如果我们返回nil, 则整个链会产生PMKError.compectMap
//        _ = cook()
//            .map { $0 + ", 配上一碗汤" }
//            .then(eat)
//            .done { data in
//                print(data)
//            }
        
        
        // get.tap
        // 如果想在链路中获取值用于其他操作, 用这两个方法, 他们不会影响到原有链路逻辑
        _ = cook()
            .get { data in
                print("---> \(data)")
            }.tap { print("tap: \($0)") }
            .then(eat)
            .then(wash)
            .done { data in print(data) }

        
        
        // when
        // 提供并行执行异步操作的能力, 并且在所有异步操作执行完成后才执行回调
        // 和其他的promise链一样, when方法中 任一异步操作发生错误, 都会进入到下一个 catch方法中
        
        // race
        // race用法和when一样, 却别: when等所有异步操作都执行完成后才执行then回调, 而race的话, 只要一个异步操作执行完成, 就立即执行then回调, 没有执行完的回调, 仍会继续执行
        
        // Guarantee
        // Guarantee 是 Promise的变种或者补充,
        // 区别是: promise状态是可以是成功或者失败, Guarantee要确保永不失败
        
        // after()
        // 延时执行
        
    }
}

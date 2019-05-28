//
//  ViewController.swift
//  TestPromiss
//
//  Created by IOS3 on 2019/5/9.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import PromiseKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "PromiseKit_01"
        
//         testPromise_02()
        testRace()
    }


}

fileprivate typealias Doc = ViewController
extension Doc {
    /*
     - fulfill 方法吧 promise 的状态置为完成状态(fulfilled), 这是then 方法就能捕捉到, 并执行成功情况的回调
     - reject 方法把 promise 的状态置为失败(rejected), 这时就能进到 catch 方法
     - finally 方法, 不管成功失败, 都会进入finally 方法
     - then 方法, 要求传入一个promise, 返回一个promise
     - map() 是根据先前的promise结果, 然后返回一个新的对象或值类型
     - compactMap(), 与map类似, 其返回Optional, 如果我们返回nil, 则整个链会产生 PMKError.compactMap 错误
     - 如果想要在链路中获取值用于其他操作，比如输出调试。那么可以使用 get()、tap() 这两个方法，它们都不会影响到原有链路逻辑
     
     - when 方法提供了并行执行异步操作的能力，并且只有在所有异步操作执行完后才执行回调。 和其他的 promise 链一样，when 方法中任一异步操作发生错误，都会进入到下一个 catch 方法中。
     - race 的用法与 when 一样，如果有一个方法执行完成就会立即返回.
     
     - Guarantee 是 Promise 的变种、或者补充，其用法和 Promise 一样，大多情况下二者可以互相替换使用。 与 Promise 状态可以是成功或者失败不同，Guarantee 要确保永不失败，因此语法也更简单些。
     - after() PromiseKit 封装的延迟方法
     let g = Guarantee<String> { seal in
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
             print("洗碗完毕！")
             seal("干净的碗筷")
         }
     }
     */
}

fileprivate typealias Test = ViewController
fileprivate extension Test {
    func testPromise_01() -> () {
        _ = cook()
            .then({ data -> Promise<String> in
                return self.eat(data: data)
            })
            .then({ (data) -> Promise<String> in
                return self.wash(data: data)
            })
            .done({ (data) in
                print(data)
            })
    }
    func testPromise_02() -> () {
        _ = cook()
            .map{ $0 + "配上一碗汤" }
            .then(eat)
            .get{ print("deubg: then(eat): data=\($0) 😂")}
            .then(wash)
            .tap{ print("dubg: then(wash): \($0) 😂") }
            .done({ (data) in
                print(data)
            })
            .catch({ (error) in
                print(error.localizedDescription + "没法吃")
            })
            .finally {
                print("出门上班")
            }
    }
    func testWhen() -> Void {
        _ = when(fulfilled: cutup(), boil())
            .done { print("结果: \($0) \($1)")}
    }
    func testRace() -> Void {
        _ = race(cutup(), boil())
            .done{ print("data: \($0) ")}
    }
}


fileprivate typealias TestPromiss = ViewController
fileprivate extension TestPromiss {
    
    func cook() -> Promise<String> {
        print("开始做饭")
        let p = Promise<String> { (reslover) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                print("做饭完毕")
                reslover.fulfill("鸡蛋炒饭")
//                let error = NSError(domain: "cook.error", code: 2333, userInfo: [NSLocalizedDescriptionKey : "米饭烧焦了"])
//                reslover.reject(error)
            })
        }
        return p
    }
    
    func eat(data: String) -> Promise<String> {
        print("j开始吃饭" + data)
        let p = Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print("吃饭完毕")
                 resolver.fulfill("一个碗和一双筷子")
            })
        }
        return p
    }
    func wash(data: String) -> Promise<String> {
        print("开始洗碗: \(data)")
        let p = Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print("洗碗完毕")
                resolver.fulfill("f干净的碗")
            })
        }
        return p
    }
    
    // 切菜
    func cutup() -> Promise<String> {
        print("开始切菜")
        let p = Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print("切菜完毕")
                resolver.fulfill("切好的菜")
            })
        }
        return p
    }
    // 烧水
    func boil() -> Promise<String> {
        print("开始烧水")
        let p = Promise<String> { resolver in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print("烧水完毕")
                resolver.fulfill("烧好的水")
            })
        }
        return p
    }
}


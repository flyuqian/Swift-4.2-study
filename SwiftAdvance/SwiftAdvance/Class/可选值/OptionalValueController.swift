//
//  OptionalValueController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/8.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class OptionalValueController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test2()
//        test3()
//        test5()
        test8()

    }

}

// 可选值, 是一个枚举, 有.none 和 .some 两个标签
// Optional在 Swift 中非常基础, Optional<Index>,可以解析为Index?
// 也可以用 nil 代替.none
// Optional 使编译器对使用值进行检查
extension OptionalValueController {
    fileprivate func test1() -> Void {
        var arr = ["one", "two", "three"]
        switch arr.lastIndex(of: "four") {
        case .some(let idx):
            arr.remove(at: idx)
        case .none:
            break
        }
        
        // 使用 nil 适配 .none
        switch arr.lastIndex(of: "four") {
        case let idx?:
            arr.remove(at: idx)
        case nil:
            break
        }
    }
}

// MARK: 可选值 概览
extension OptionalValueController {
    // 使用 if let 语句
    fileprivate func test2() {
        var arr = ["one", "two", "three", "four"]
        if let idx = arr.lastIndex(of: "four") {
            arr.remove(at: idx)
        }
        // 可以在一个 if 语句中绑定多个值, 后面的绑定可基于前面的绑定完成
        if let idx = arr.lastIndex(of: "four"), idx != arr.startIndex {
            arr.remove(at: idx)
        }
        // 如下边
        let urlString = "https://www.objc.io/logo.png"
        if let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            let imageView = UIImageView(image: image)
            imageView.frame = view.bounds
            view.addSubview(imageView)
        }
    }
    
    private func test3() {
        let scanner = Scanner(string: "lisa 123")
        var username: NSString?
        let alphas = CharacterSet.alphanumerics
        
        if scanner.scanCharacters(from: alphas, into: &username),
            let name = username {
            print(name)
        }
    }
    
    // while let 表示一个当条件返回 nil是时终止循环
    private func test4() {
        while let line = readLine(), !line.isEmpty {
            print(line)
        }
        
        //
        let arr = [1, 2, 3, 4]
        var iterator = arr.makeIterator()
        while let i = iterator.next() {
            print(i, terminator: " ")
        }
        // 或者
        for i in 0..<10 where i % 2 == 0 {
            print(i, terminator: " ")
        }
    }
    
}


// MARK: 双重 可选值
extension OptionalValueController {
    fileprivate func test5() {
        let stringNumbers = ["1", "2", "three"]
        let maybeInts = stringNumbers.map { Int($0) }
        for x in maybeInts {
            print(x)
        }
        var iterator = maybeInts.makeIterator()
        print(iterator.next())
        // iterator.next() 编译器提示为 Int?? 打印结构为Optional(Optional(1))
        // for in 循环, 已经使用 while let检查这个值是不是 nil
        //
        // 使用case 模式匹配
        // 这里 i? 是 .some(i)的简写
        for case let i? in maybeInts {
            print(i)
        }
        for case nil in maybeInts {
            print("no value")
        }
        // ~= 运算符
        /*
         struct Pattern {
             let s: String
                init(_ s: String) { self.s = s }
             }
             func ~=(pattern: Pattern, value: String) -> Bool {
                return value.range(of: pattern.s) != nil
             }
             let s = "Taylor Swift"
             if case Pattern("Swift") = s {
             print("\(String(reflecting: s)) contains \"Swift\"")
         }
         */
    }
    // if var and while var
    fileprivate func test6() {
        let number = "1"
        if var i = Int(number) {
            i += 1
            print(i)
        }
    }
    // guard
    // 在 guard else 中, 你可以做任何事, 唯一的限制, 事你必须在else 中离开当前作用域(return / fatalError, 或者其他返回 Never的方法)
    // Never 无人类型, 没有有效值, 不能被构建, 唯一作用是给g编译器提供信号, , 一个被声明为 Never的函数将永远无法正常返回
    // Swift中, Never 用一个不包含任意成员的 enum 实现
    //
    // Swift 中的无类型, nil Never Void
    //
    // guard 能够接受任何在普通的 if 语句中能够接受的条件
    fileprivate func test7() {
        var arr: [Int] = []
        guard arr.isEmpty else { return }
    }
}


// MARK: 可选链
extension OptionalValueController {
    fileprivate func test8() {
        let str: String? = "Never say never"
        let upper: String
        if str != nil {
            upper = str!.uppercased()
        }
        else {
            fatalError("str is nil")
        }
        // 上面的 upper 可以
        let upper2 = str?.uppercased().lowercased()
        // str?.uppercased() 会 返回一个可选, 但是 uppercassed() 的返回值是 string, 其结果可选因为 str 的可选
        // lowercased() 的调用者, 在上步调用时已经确认, 所以不必使用可选调用
        let a = 20.half?.half?.half?.half
        // 因为 half 计算属性的每一步都有可能返回 nil, 所以调用前都需要?, 声明 这一步的.hslf 不一定被调用
        
        // 可选连对下标和函数也适用
        let dic = ["nine" : [0, 1, 2, 3]]
        dic["nine"]?[3]
        
        let dicFuncs: [String : (Int, Int) -> Int] = [
            "add" : (+),
            "subtract" : (-)
        ]
        let rst = dicFuncs["add"]?(1, 1)
        print(rst ?? 0)
        // TestField 案例, 下边
        class TextField {
            private(set) var text = ""
            var didChange: ((String) -> ())?
            
            private func textDidChange(newText: String) {
                text = newText
                didChange?(text)
            }
        }
        
        
        // 通过可选链 赋值
        struct Person {
            var name: String
            var age: Int
        }
        var optionalLisa: Person? = Person(name: "lisa", age: 8)
        if optionalLisa != nil {
            optionalLisa!.age += 1
        }
        // 对于上边的情况 不能使用可选绑定,
        // 因为 struct 是值类型, 可选绑定会对这个值进行赋值, 更改操作作用不到这个值上
        // 如果 Person 是类的话, 我们可以使用可选绑定
        
        
        // MARK: ** 很有意思的题
        var aa: Int? = 5
        aa? = 10
        print(aa)
        // Optional(10)
        aa = 20
        print(aa)
        // Optional(20)
        
        var bb: Int? = nil
        bb? = 10
        print(bb)
        // nil
        bb = 20
        print(bb)
        // Optional(20)
        //
        // a = 10 和 a? = 10 的区别
        // 前一种写法, 无条件的将一个新值赋值给变量
        // 后一种写法, 只在 a 的值赋值前不是 nil 的时候才生效
        
    }
}
fileprivate extension Int {
    var half: Int? {
        guard self < -1 || self > 1 else {
            return nil
        }
        return self / 2
    }
}




// MARK: nil 合并云算符 ??
// 注意 a ?? b ?? c 和 (a ?? b) ?? c 的区别
// 前者是合并操作的链接, 后者是先解包()内的内容, 在处理外层
// ?? 两侧类型必须相同


// MARK: 在字符串插值中使用可选值
// 尝试打印可选值, 或者将可选值用在字符串插值表达式中时, 编译器会给出警告, 其目的是防止将 Optional(...) 显示给用户
// 在打印时, 消除警告的做法, (as Any), (!强解), (用 String(decribing...)包装), (?? 提供默认值)



// MARK: 可选值 map
// 获取一个可选值, 并且当它不是nil的视乎进行转换的模式十分常见, Swift中专门处理这种情况的方法是 map
// map方法 接受一个闭包, 如果可选值有内容, 则调用这个闭包进行转换
extension OptionalValueController {
    fileprivate func test9() {
        let characters: [Character] = ["a", "b", "c"]
        let fistChar = characters.map { String($0) }
    }
}
// 这里书中有案例 一种 reduce 函数的实现




// MARK: 可选值 flatMap



//
//  RegularController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 在语言层面上 不支持 正则表达式
// 自定义 =~ 运算符
//  在 Cocoa 中我们可以使用 NSRegularExpression 来做正则匹配，那么其实我们为它写一个包装也并不是什么太困难的事情。因为做的是字符串正则匹配，所以 =~ 左右两边都是字符串。我们可以先写一个接受正则表达式的字符串，以此生成 NSRegularExpression 对象。然后使用该对象来匹配输入字符串，并返回结果告诉调用者匹配是否成功。
// 正则表达式 30分钟入门: http://deerchao.net/tutorials/regex/regex.htm
// 8个常用正则表大会:  https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149

import UIKit

class RegularController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        
        let matcher: RegexHelper
        do {
            matcher = try RegexHelper(mailPattern)
            let maybeMailAddress = "onev@onevcatlcom"
            if matcher.match(maybeMailAddress) {
                print("有效的邮箱地址")
            }
        }
        catch {
            
        }
        
        if "onev@onevcat.com" =~ "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
            print("邮箱地址有效")
        }
    }

}

fileprivate struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}

// 封装
precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}

infix operator =~: MatchPrecedence

fileprivate func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch _ {
        return false
    }
}


//
//  DimMatchController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 模糊匹配的API
//  func ~=<T : Equatable>(a: T, b: T) -> Bool
//  func ~=<T>(lhs: _OptionalNilComparisonType, rhs: T?) -> Bool
//  func ~=<I : IntervalType>(pattern: I, value: I.Bound) -> Bool


import UIKit

class DimMatchController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        func test() {
            
            // 可以判等的类型的判断
            print("可以判等的类型的判断")
            let password = "akfuv(3"
            switch password {
            case "akfuv(3":
                print("密码通过")
            default:
                print("验证失败")
            }
            
            // 对Optional的判等
            print("对Optional的判等")
            let num: Int? = nil
            switch num {
            case nil:
                print("没值")
            default:
                print("\(num!)")
            }
            
            // 对范围的判断
            print("对范围的判断")
            let x = 0.5
            switch x {
            case -1.0...1.0:
                print("区间内")
            default:
                print("区间外")
            }
            
            // Swift 的 Switch, 使用 ~= 操作符进行模式匹配
            // case指定模式作为左参数, Switch元素作为又参数
        }
        
        
        // 使用下面的操作符, 在Switch里匹配字符串
        func test2() {
            let contact = ("http://onevcat.com", "onev@onevcat.com")
            
            do {
                guard let mailRegex = try? ~/"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" else { return }
                guard let siteRegex = try? ~/"^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$" else { return }
                switch contact {
                case (siteRegex, mailRegex):
                    print("同时拥有有效的网站和邮箱")
                case (_, mailRegex):
                    print("只拥有有效的邮箱")
                case (siteRegex, _):
                    print("只拥有有效的网站")
                default:
                    print("都不匹配")
                }
            }
            
            
            
        }
        
        
        test()
        test2()
    }
}

// 重载 ~= 操作符
fileprivate func ~=(pattern: NSRegularExpression, input: String) -> Bool {
    return pattern.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) > 0
}

// 为了方便, 我们再添加一个将字符串转换为 NSRegularExpression 的操作符 (不使用 ExpressibleStringLiteral)
prefix operator ~/
fileprivate prefix func ~/(pattern: String) throws -> NSRegularExpression {
    do {
        let expression = try NSRegularExpression(pattern: pattern, options: [])
        return expression
    }
    catch(let error) {
        throw error
    }
}

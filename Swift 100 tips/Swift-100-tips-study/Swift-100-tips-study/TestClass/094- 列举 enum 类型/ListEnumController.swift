//
//  ListEnumController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/26.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class ListEnumController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
}

// 扑克牌案例
fileprivate enum Suit: String {
    case spades = "黑桃"
    case hearts = "红桃"
    case clubs = "草花"
    case diamonds = "方片"
}

fileprivate enum Rank: Int, CustomStringConvertible {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    var description: String {
        switch self {
        case .ace:
            return "A"
        case .jack:
            return "J"
        case . queen:
            return "Q"
        case .king:
            return "K"
        default:
            return String(self.rawValue)
        }
    }
}
// 其他语言, 可以两次遍历得到所有的 牌型
// Swift, 由于在 enum 某一个case中我们可以添加具体值的(如: case some(T) ), 所以for in 无法表达出所有的情况, 不过我们在这个特定的情况中并没有带有参数的枚举类型, 所以我们可以利用static 的属性来获取一个可以进行循环的数据结构

fileprivate protocol EnumeratableEnum {
    static var allValues: [Self] {get}
}

extension Suit: EnumeratableEnum {
    static var allValues: [Suit] {
        return [.spades, .hearts, .clubs, .diamonds]
    }
}
extension Rank: EnumeratableEnum {
    static var allValues: [Rank] {
        return [.ace, .two, .three,
                .four, .five, .six, .seven, .eight, .nine,
                .jack, .queen, .king]
    }
}
// 这样, 就可以 遍历得到所有结果

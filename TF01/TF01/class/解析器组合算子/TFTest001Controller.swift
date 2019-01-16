//
//  TFTest001Controller.swift
//  TF01
//
//  Created by IOS3 on 2018/12/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFTest001Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        view.backgroundColor = .white
        
        test1()
    }
    

    func test1() {
        let one = character { $0 == "1" }
        one.parse("123".characters)
        print(one.run("123")?.1)
    }

}


// 解析器, 将一系列符号(通常是一组字符)转换为结构化的数据
// 解析器组合算子是一种函数式的解析方案
//MARK: 解析器类型
//typealias Parser<Result> = (String) -> (Result, String)?
//typealias Stream = String.CharacterView
//typealias Parser<Result> = (Stream) -> (Result, Stream)?
struct Parser<Result> {
    typealias Stream = String.CharacterView
    let parse: (Stream) -> (Result, Stream)?
}
extension Parser {
    func run(_ string: String) -> (Result, String)? {
        guard let (result, remainder) = parse(string.characters) else { return nil }
        return (result, String(remainder))
    }
}

extension CharacterSet {
    func contains(_ c: Character) -> Bool {
        let scalars = String(c).unicodeScalars
        guard scalars.count == 1 else {
            return false
        }
        return contains(scalars.first!)
    }
}

func character(matching condition: @escaping (Character) -> Bool) -> Parser<Character> {
    return Parser(parse: { input in
        guard let char = input.first, condition(char) else { return nil }
        return (char, input.dropFirst())
    })
}

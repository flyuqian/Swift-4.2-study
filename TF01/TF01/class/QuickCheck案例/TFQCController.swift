//
//  TFQCController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFQCController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Quick Check"
        view.backgroundColor = .white
        
        test01()
        
    }
    
    
    func test01() {
        check1("area should be a least 0") { (size: CGSize) -> Bool in
            size.area >= 0
        }
    }
    

    fileprivate func check1<A: Arbitrary>(_ message: String, _ property: (A) -> Bool) {
        let numberOfIterations = Int.arbitrary(in: 1000..<2000)
        
        for _ in 0..<numberOfIterations {
            let value = A.arbitrary()
            guard property(value) else {
                print("\"\(message)\" dose not hold: \(value)")
                return
            }
        }
        print("\"\(message)\" passed tests")
    }
    
    func iterate<A>(while condition: (A) -> Bool, initial: A, next: (A) -> A?) -> A {
        guard let x = next(initial), condition(x) else {
            return initial
        }
        return iterate(while: condition, initial: x, next: next)
    }

//    func check2<A: Arbitrary>(_ message: String, _ property: (A) -> Bool) -> Void {
//        let numberOfIterations = Int.arbitrary(in: 1000..<2000)
//        for _ in 0..<numberOfIterations {
//            let value = A.arbitrary()
//            guard property(value) else {
//                let smallerValue = iterate(while: { !property($0) }, initial: value) { (x) -> A? in
//                    return x.smaller()
//                }
//                return
//            }
//        }
//    }
}



fileprivate protocol Arbitrary :Smaller {
    static func arbitrary() -> Self
}

// 生成随机整数
extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}

// 为了防止随机整数越界, 我们添加一个变量对其进行约束
extension Int {
    static func arbitrary(in range: CountableRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        return range.lowerBound + (Int.arbitrary() % diff)
    }
}


// 生成随机字符
extension UnicodeScalar: Arbitrary {
    func smaller() -> Unicode.Scalar? {
        return nil
    }
    
    static func arbitrary() -> UnicodeScalar {
        return UnicodeScalar(Int.arbitrary(in: 65..<90))!
    }
}

// 0~40之间的数长度的字符串
extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = Int.arbitrary(in: 0..<40)
        let randomScalars = (0..<randomLength).map { _ in UnicodeScalar.arbitrary() }
        return String(UnicodeScalarView(randomScalars))
    }
}


// 用于测试
extension CGSize {
    var area: CGFloat {
        return width * height
    }
}
extension CGSize: Arbitrary {
    func smaller() -> CGSize? {
        return nil
    }
    
    static func arbitrary() -> CGSize {
        return CGSize(width: Int.arbitrary(), height: Int.arbitrary())
    }
}


// Smaller 用于缩小范围
protocol Smaller {
    mutating func smaller() -> Self?
}
extension Int: Smaller {
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}
extension String: Smaller {
    
    mutating func smaller() -> String? {
        return isEmpty ? nil : String(self.remove(at: self.startIndex))
    }
}


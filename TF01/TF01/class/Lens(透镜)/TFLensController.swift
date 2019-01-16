//
//  TFLensController.swift
//  TF01
//
//  Created by IOS3 on 2019/1/10.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit

class TFLensController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}


// https://juejin.im/post/5b41bd52e51d4519646218dc
// lens是一个抽象概念, 作用是能够深入到数据结构内部, 观察和修改内部的数据结构



extension TFLensController {
    struct Point {
        let x: CGFloat
        let y: CGFloat
    }
    
    struct Line {
        let start: Point
        let end: Point
    }
    
    // 使用一条线段和一个端点确定一个三角形
    struct Triangle {
        let line: Line
        let point: Point
    }
}

// 定义 Lens
typealias Lens<Subpart, Whole> = (@escaping (Subpart) -> (Subpart)) -> (Whole) -> Whole
// Whole, 指数据结构本身, Subpart 指待了结构中特定字段的类型
extension TFLensController.Point {
    static let xL: Lens<CGFloat, TFLensController.Point> = { mapper in
        return { old in
            return TFLensController.Point(x: mapper(old.x), y: old.y)
        }
    }
    static let yL: Lens<CGFloat, TFLensController.Point> = { mapper in
        return { old in
            return TFLensController.Point(x: old.x, y: mapper(old.y))
        }
    }
}
extension TFLensController.Line {
    // start字段的Lens
    static let startL: Lens<TFLensController.Point, TFLensController.Line> = { mapper in
        return { old in
            return TFLensController.Line(start: mapper(old.start), end: old.end)
        }
    }

    // end字段的Lens
    static let endL: Lens<TFLensController.Point, TFLensController.Line> = { mapper in
        return { old in
            return TFLensController.Line(start: old.start, end: mapper(old.end))
        }
    }
}
// 这时, Lens的构建复杂, 下面定义一个Lens的构建函数
func lens<Subpart, Whole>(view: @escaping (Whole) -> Subpart, set: @escaping (Subpart, Whole) -> Whole) -> Lens<Subpart, Whole> {
    return { mapper in { set(mapper(view($0)), $0) } }
}
// lens 的两个参数 view/set, 分别代表着 Getter和Setter
// viwe (B)->A, B代表数据结构本身, A代表这个数据结构中的某个字段, 这个函数的目的就是为了从函数本身获取到指定的字段的值
// set (A, B)->B, A是经过转换后得到的新的字段值, B为旧的数据结构值. B则是基于旧的数据结构B和新的字段值A构建出来的新数据
// 使用lens函数构建 Lens
extension TFLensController.Point {
    static let xLens = lens(
        view: { $0.x },
        set: { TFLensController.Point(x: $0, y: $1.y) }
    )
    static let yLens = lens(
        view: { $0.y },
        set: { TFLensController.Point(x: $1.x, y: $0) }
    )
}

extension TFLensController.Line {
    static let startLens = lens(
        view: { $0.start },
        set: { TFLensController.Line(start: $0, end: $1.end) }
    )
    static let endLens = lens(
        view: { $0.end },
        set: { TFLensController.Line(start: $1.start, end: $0) }
    )
}

// 定义 over 和 set 函数
func over<Subpart, Whole>(mapper: @escaping (Subpart) -> Subpart, lens: Lens<Subpart, Whole>) -> (Whole) -> Whole {
    return lens(mapper)
}

func set<Subpart, Whole>(value: Subpart, lens: Lens<Subpart, Whole>) -> (Whole) -> Whole {
    return over(mapper: { _ in value }, lens: lens)
}



// 函数组合
// 定义函数组合运算符
//func >>> <A, B, C> (lhs: @escaping (A) -> B, rhs: @escaping (B) -> C) -> (A) -> C {
//    return { rhs(lhs($0)) }
//}
//
//func <<< <A, B, C> (lhs: @escaping (B) -> C, rhs: @escaping (A) -> B) -> (A) -> C {
//    return { lhs(rhs($0)) }
//}


extension TFLensController {
    
    
    func test1() {
        
        
        
        let mPoint = Point(x: 2, y: 3)
        // mPoint.x = 5; 因为不可变而报错
        // 使用新数据替换, 进行不可变数据的改变
        let bPoint = Point(x: mPoint.x, y: mPoint.y + 2)
        
        
        // 当数据结构变得复杂, 如下
        // 代表线段的结构体
        
        
        // 线段A
        let aLine = Line(
            start: Point(x: 2, y: 3),
            end: Point(x: 5, y: 7)
        )
        
        // 将线段A的起点向上移动2个坐标点，得到一条新的线段B
        let bLine = Line(
            start: Point(x: aLine.start.x, y: aLine.start.y),
            end: Point(x: aLine.end.x, y: aLine.end.y - 2)
        )
        
        // 将线段B向右移动3个坐标点，得到一条新的线段C
        let cLine = Line(
            start: Point(x: bLine.start.x + 3, y: bLine.start.y),
            end: Point(x: bLine.end.x + 3, y: bLine.end.y)
        )
        
        // 三角形A
        let aTriangle = Triangle(
            line: Line(
                start: Point(x: 10, y: 15),
                end: Point(x: 50, y: 15)
            ),
            point: Point(x: 20, y: 60)
        )
        
        // 改变三角形A线段的末端点，让其成为一个等腰三角形B
        let bTriangle = Triangle(
            line: Line(
                start: Point(x: aTriangle.line.start.x, y: aTriangle.line.start.y),
                end: Point(x: 30, y: aTriangle.line.end.y)
            ),
            point: Point(x: aTriangle.point.x, y: aTriangle.point.y)
        )
        
        
        // 此时如需要改变 bTraiage, 将变得复杂
        
    }
    
    // 定义好各个字段的 Lens 后, 通过 set over 函数来对数据结构进行修改
    func test2() {
        
        let aPint = Point(x: 2, y: 3)
        let setYTo5 = set(value: 5, lens: Point.yLens)
        let bPoint = setYTo5(aPint)
        
        let moveRight3 = over(mapper: { $0 + 3 }, lens: Point.xLens)
        let cPoint = moveRight3(aPint)
    }
    
    
    
}



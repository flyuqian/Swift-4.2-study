//
//  Protocol1C.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2019/2/28.
//  Copyright © 2019 com.test. All rights reserved.
//

import UIKit

class Protocol1C: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}




protocol Drawing {
    mutating func addElipse(rect: CGRect, fill: UIColor)
    mutating func addRectangle(rect: CGRect, fill: UIColor)
}
// 协议的最强大特性之一就是我们可以以追溯的方式修改任意类型, 让他们满足协议
extension CGContext: Drawing {
    func addElipse(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        fillEllipse(in: rect)
    }
    
    func addRectangle(rect: CGRect, fill fillColor: UIColor) {
        setFillColor(fillColor.cgColor)
        fill(rect)
    }
}
// 要表示SVG文件, 我们创建一个SVG结构体, 它包含一个带有子节点的XMLNode, 以及append方法
struct XMLNode {
    var tag: String
    var children = [XMLNode]()
    init(tag: String) {
        self.tag = tag
    }
}
struct SVG {
    var rootNode = XMLNode(tag: "svg")
    mutating func append(node: XMLNode) {
        rootNode.children.append(node)
    }
}
extension SVG: Drawing {
    func addElipse(rect: CGRect, fill: UIColor) {
    }
    func addRectangle(rect: CGRect, fill fillColor: UIColor) {
    }
}

//MARK: 协议拓展
extension Drawing {
    mutating func addCircle(center: CGPoint, radius: CGFloat, fill: UIColor) {
        let diameter = radius * 2
        let orign = CGPoint(x: center.x - radius, y: center.y - radius)
        let size = CGSize(width: diameter, height: diameter)
        let rect = CGRect(origin: orign, size: size)
        addElipse(rect: rect, fill: fill)
    }
}
// 通过协议拓展, 我们就可以在CGContext和SVG中使用 addCircle方法
/*
 - 不需要强制使用某个父类
 - 我们可以让已经存在的类型满足协议
 - 协议可以用于类/结构体
 - 处理协议时, 我们无序担心方法重写或者在正确的事件调用super这样的问题
 */

//MARK: 在协议扩展中重写方法
// 如果我们想要SVG提供更具体的 addCircle, 我们可以重写这个方法
extension SVG {
    mutating func addCircle(center: CGPoint, radius: CGFloat, fill: UIColor) {
        
    }
}
// 如果我们使用 SVG实例调用 adCircle, 将会调用 SVG的addCircle方法
// 如果我们将SVG实例转变为Drawing类型调用addCircle方法, 将会调用协议拓展中的 addCircle方法
/*
当我们将 otherSample 定义为 Drawing 类型的变量时，编译器会自动将 SVG 值封装到一个代表协议的类型中，这个封装被称作存在容器 (existential container)，我们会在本章后面讨论具体细节。现在，我们可以这样考虑这个行为：当我们对存在容器调用 addCircle 时，方法是静态派发的，也就是说，它总是会使用 Drawing 的扩展。如果它是动态派发，那么它肯定需要将方法的接收者 SVG 类型考虑在内。
 */
// 我们将addCircle方法添加到  protocol Drawing 中, 将会使用动态派发


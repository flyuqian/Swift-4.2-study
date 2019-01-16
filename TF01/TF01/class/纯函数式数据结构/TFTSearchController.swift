//
//  TFTSearchController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFTSearchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "二叉树搜索"
        view.backgroundColor = .white
        
        let myTree: BinarySearchTree<Int> = BinarySearchTree()
        var copied = myTree
        copied.insert(5)
        print(myTree.elements)
        print(copied.elements)
    }
    

   

}


// 这里使用传统 C风格, 打造一个树形结构, 在每个节点持有指向子树的指针
indirect enum BinarySearchTree<Element: Comparable> {
    case leaf
    case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}
extension BinarySearchTree {
    init() {
        self = .leaf
    }
    init(value: Element) {
        self = .node(.leaf, value, .leaf)
    }
}
extension BinarySearchTree {
    var count: Int {
        switch self {
        case .leaf:
            return 0
        case let .node(left, _, right):
            return 1 + left.count + right.count
        }
    }
}
extension BinarySearchTree {
    var elements: [Element] {
        switch self {
        case .leaf:
            return []
        case let .node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
}
// 像这样, count/elements 的抽象出来的过程, 可以成为 fold 或 reduce
extension BinarySearchTree {
    func reduce<A>(leaf leafF: A, node nodeF:(A, Element, A) -> A) -> A {
        switch self {
        case .leaf:
            return leafF
        case let .node(left, x, right):
            return nodeF(left.reduce(leaf: leafF, node: nodeF), x, right.reduce(leaf: leafF, node: nodeF))
        }
    }
}
// 使用 reduce 写 elements 和 count
extension BinarySearchTree {
    var elementsR: [Element] {
        return reduce(leaf: [], node: { left, x, right in
            return left + [x] + right
        })
    }
    var countR: Int {
        return reduce(leaf: 0) { 1 + $0 + $2 }
    }
}

extension BinarySearchTree {
    var isEmpty: Bool {
        if case .leaf = self {
            return true
        }
        return false
    }
}

// 原文
/*
 遗憾地是，当我们试着去我们编写 insert 和 contains 函数的雏形时，看起来并没有什么可以利用的特性。不过，如果为这个结构加上一个二叉搜索树的限制，问题就会迎刃而解。如果一棵 (非空) 树符合以下几点，就可以被视为一棵二叉搜索树：
 - 所有储存在左子树的值都小于其根节点的值
 - 所有储存在右子树的值都大于其根节点的值
 - 其左右子树都是二叉搜索树
 */


extension Sequence {
    /// 检查一个数组中的所有元素是否满足某一个条件
    func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
}
// 检查一棵树是不是一颗二叉搜索树 (低效)
extension BinarySearchTree {
    var isBST: Bool {
        switch self {
        case .leaf:
            return true
        case let .node(left, x, right):
            return left.elements.all { y in y < x }
                && right.elements.all { y in y > x }
                && left.isBST
                && right.isBST
        }
    }
    
}

// 查找一个元素是否在树中
extension BinarySearchTree {
    func contains(_ x: Element) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(_, y, _) where x == y:
            return true
        case let .node(left, y, _) where x < y:
            return left.contains(x)
        case let .node(_, y, right) where x > y:
            return right.contains(x)
        default:
            fatalError("The impossible occurred")
        }
    }
}
// 插入操作
extension BinarySearchTree {
    mutating func insert(_ x: Element) {
        switch self {
        case .leaf:
            self = BinarySearchTree(value: x)
        case .node(var left, let y, var right):
            if x < y { left.insert(x) }
            if x > y { right.insert(x) }
            self = .node(left, y, right)
        }
    }
}

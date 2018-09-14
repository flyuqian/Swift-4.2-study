//
//  IndirectEnumController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// indirect 提示编译器 不要在值类型中直接嵌套
import UIKit

class IndirectEnumController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let list = Node(value: 1,
                        next: Node(value: 2,
                                   next: Node(value: 3,
                                              next: Node(value: 4, next: nil))))
        let linkedList = LinkedList.node(1, LinkedList.node(2, .node(3, .node(4, .empty))))
    }
    
    // 使用 class 定义一个单向链表
    class Node<T> {
        let value: T?
        let next: Node<T>?
        
        init(value: T?, next: Node<T>?) {
            self.value = value
            self.next = next
        }
    }
    // 缺点, 使用nil表达空节点, nil和空节点不等价
    // 如果想表达一个空链表, 需要把list设置成Optional, 或者Node的next和value都设置成nil
    
    // 使用enum
    indirect enum LinkedList<Element: Comparable> {
        case empty
        case node(Element, LinkedList<Element>)
    }
}

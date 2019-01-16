//
//  CompleDicController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class CompleDicController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "基于字典树的自动补全"
        view.backgroundColor = .white
        
        
        // testSliceDecomposed()
        test1()
    }
    
    
    
    func test1() {
        let contents = ["cat", "car", "cart", "dog"]
        let trieOfWords = Trie<Character>.build(words: contents)
        let rst = "car".complete(trieOfWords)
        print(rst)
    }


    func testSliceDecomposed() {
        func sum(_ intergers: ArraySlice<Int>) -> Int {
            guard let (head, tail) = intergers.decomposed else { return 0 }
            return head + sum(tail)
        }
        
        let sums = sum([1, 2, 3, 4, 5].slice)
        print(sums)
    }

}



struct Trie<Element: Hashable> {
    /// 标记截止当前节点的额字符串是否在树中
    let isElement: Bool
    let children: [Element: Trie<Element>]
}

// 空节点
extension Trie {
    init() {
        isElement = false
        children = [:]
    }
}
// 定义属性, 将字典树展平flatten为一个包含全部元素的数组
extension Trie {
    var elements: [[Element]] {
        var result: [[Element]] = isElement ? [[]] : []
        for (key, value) in children {
            result += value.elements.map { [key] + $0 }
        }
        return result
    }
}
/*
 这个函数的内部实现十分精妙。首先，我们会检查当前的根节点是否被标记为一棵字典树的成员。
 如果是，这个字典树就包含了一个空的键，反之，result 变量则会被实例化为一个空的数组。
 接着，函数会遍历字典，计算出子树的所有元素 —— 这是通过调用 value.elements 实现的。
 最后，每一棵子字典树对应的 “character” (也就是代码中的 key) 会被添加到子树 elements 的首位 —— 这正是 map 函数中所做的事情。
 虽然我们也可以使用 flatmap 函数取代 for 循环来实现属性 elements，不过现在的代码让整个过程能稍微清晰一些。
 */
extension Array {
    var slice: ArraySlice<Element> {
        return ArraySlice(self)
    }
}
extension ArraySlice {
    var decomposed: (Element, ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex], self.dropFirst())
    }
}

// 给定一个由一些 Element 组成的箭镞, 遍历一棵字典树, 来逐一确定对应的键是否存储在树中
extension Trie {
    func lookup(key: ArraySlice<Element>) -> Bool {
        guard let (head, tail) = key.decomposed else { return isElement }
        guard let subtrie = children[head] else { return false }
        return subtrie.lookup(key: tail)
    }
    func lookup(key: ArraySlice<Element>) -> Trie<Element>? {
        guard let (head, tail) = key.decomposed else { return self }
        guard let remainder = children[head] else { return nil }
        return remainder.lookup(key: tail)
    }
}

extension Trie {
    func complete(key: ArraySlice<Element>) -> [[Element]] {
        return lookup(key: key)?.elements ?? []
    }
}

extension Trie {
    init(_ key: ArraySlice<Element>) {
        if let (head, tail) = key.decomposed {
            let children = [head : Trie(tail)]
            self = Trie(isElement: false, children: children)
        }
        else {
            self = Trie(isElement: true, children: [:])
        }
    }
}

// 通过插入函数填充字典树
extension Trie {
    func inserting(_ key: ArraySlice<Element>) -> Trie<Element> {
        guard let (header, tail) = key.decomposed else { return Trie(isElement: true, children: children) }
        var newChildren = children
        if let nextTrie = children[header] {
            newChildren[header] = nextTrie.inserting(tail)
        }
        else {
            newChildren[header] = Trie(tail)
        }
        return Trie(isElement: isElement, children: newChildren)
    }
}

// 😂
extension Trie {
    static func build(words: [String]) -> Trie<Character> {
        let emptyTrie = Trie<Character>()
        return words.reduce(emptyTrie) { trie, word in
            trie.inserting(Array(word.characters).slice)
        }
    }
}
extension String {
    func complete(_ knownWords: Trie<Character>) -> [String] {
        let chars = Array(characters).slice
        let completed = knownWords.complete(key: chars)
        return completed.map { chars in
            self + String(chars)
        }
    }
}

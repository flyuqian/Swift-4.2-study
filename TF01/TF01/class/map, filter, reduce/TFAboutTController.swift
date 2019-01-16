//
//  TFAboutTController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFAboutTController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "泛型介绍"
        view.backgroundColor = .white
    }
    

    // 泛型应用, Map
    func genericCompute<Element, T>(array: [Element], transform: (Element) -> T) -> [T] {
        var result: [T] = []
        for x in array {
            result.append(transform(x))
        }
        return result
    }
   

}

// filter
fileprivate extension Array {
    func filtre_t(_ includeElement: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

// reduce
fileprivate extension Array {
    func reduce_t<T>(_ initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}


// 案例: 有一个数组, 它的元素是数组, 如果我们想把数组展开
fileprivate func flatten<T>(_ xss: [[T]]) -> [T] {
    var result: [T] = []
    for xs in xss {
        result += xs
    }
    return result
}
// 使用reduce定义上面的函数
fileprivate func flatten_r<T>(_ xss: [[T]]) -> [T] {
    return xss.reduce_t([], combine: +)
}


// 使用 reduce 定义 map 和 filter
fileprivate extension Array {
    func map_r<T>(_ transfrom: (Element) -> T) -> [T] {
        return reduce([], { (result, x) -> [T] in
            return result + [transfrom(x)]
        })
    }
    func filter_r(_ includeElement: (Element) -> Bool) -> [Element] {
        return reduce([]) { resutl, x in
            return includeElement(x) ? resutl + [x] : resutl
        }
    }
}

//MARK: ---
/*
 请务必注意：尽管通过 reduce 来定义一切是个很有趣的练习，但是在实践中这往往不是一个什么好主意。原因在于，不出意外的话你的代码最终会在运行期间大量复制生成的数组，换句话说，它会反复分配内存，释放内存，以及复制大量内存中的内容。比如说，用一个可变结果数组来编写 map 的效率显然会更高。理论上，编译器可以优化上述代码，使其速度与可变结果数组的版本一样快，但是 Swift (目前) 并没有那么做
 */


//MARK: - 泛型 和 Any
// 泛型, 用于灵活定义函数, 类型检查有编译器负责
// Any 可以避开Swift类型系统

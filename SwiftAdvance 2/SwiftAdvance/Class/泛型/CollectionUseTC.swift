//
//  CollectionUseTC.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2019/2/27.
//  Copyright © 2019 com.test. All rights reserved.
//

import UIKit

class CollectionUseTC: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}



//MARK: 集合随机排序
// 洗牌算法
//extension Array {
//    mutating func shuffle() {
//        for i in 0..<(count - 1) {
//            let j = Int(arc4random_uniform(UInt32(count - i))) + i
//            self.swapAt(i, j)
//        }
//    }
//    func shuffled() -> [Element] {
//        var clone = self
//        clone.shuffle()
//        return clone
//    }
//}







//MARK: 二分查找
extension RandomAccessCollection {
    public func binarySearch(for value: Element, areInIncreasingOrder: (Element, Element) -> Bool) -> Index? {
        guard !isEmpty else {
            return nil
        }
        var left = startIndex
        var right = index(before: endIndex)
        while left <= right {
            let dist = distance(from: left, to: right)
            let mid = index(left, offsetBy: dist/2)
            let candidate = self[mid]
            if areInIncreasingOrder(candidate, value) {
                left = index(after: mid)
            }
            else if areInIncreasingOrder(value, candidate) {
                right = index(before: mid)
            }
            else {
                return mid
            }
        }
        return nil
    }
}
extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element) -> Index? {
        return binarySearch(for: value, areInIncreasingOrder: <)
    }
}

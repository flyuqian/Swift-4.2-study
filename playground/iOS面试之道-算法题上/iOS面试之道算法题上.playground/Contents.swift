//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 字典和集合:给出一个整型数组和一个目标值,判断数组中是否有两个数之和等于目标值
// 这种方法的时间复杂度为O(n),较选中一个数然后遍历整个数组这种复杂度为 O(n^2) 的方法要好很多.
func towSum (nums: [Int], _ target: Int) -> Bool {
    var set = Set<Int>()
    for num in nums {
        if set.contains(target - num) {
            return true
        }
        set.insert(num)
    }
    return false
}

let nums = [2, 3, 4, 5, 6, 7]



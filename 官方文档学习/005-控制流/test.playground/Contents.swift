//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
case 4, 6:
    description += " in (4, 6)"
default:
    description += " an integer."
}
print(description)

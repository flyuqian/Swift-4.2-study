//
//  TFInfunc01Controller.swift
//  TF01
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFInfunc01Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        main()
    }
    
    fileprivate func main() {
        
    }
    
    
    
    

}


fileprivate typealias Distance = Double
fileprivate struct Position {
    var x: Double
    var y: Double
}
extension Position {
    func within(range: Distance) -> Bool {
        return sqrt(x*x + y*y) <= range
    }
}
fileprivate struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}
extension Ship {
    // 判断目标船只是否在攻击范围内
    func canEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx + dy*dy)
        return targetDistance <= firingRange
    }
    // 判断目标在攻击范围内, 并且在自己禁区外
    func canSafelyEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx + dy*dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
    // 为保证己方其他船只安全, 变形为
    func canSafelyEngage(ship target: Ship, friendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx + dy*dy)
        let fdx = friendly.position.x - target.position.x
        let fdy = friendly.position.y - target.position.y
        let friendlyDistance = sqrt(fdx*fdx + fdy*fdy)
        return targetDistance <= firingRange
            && targetDistance > unsafeRange
            && friendlyDistance > unsafeRange
    }
    // 向以上案例, 代码因为需求的增加 变得难以维护
}
// 向 position 添加辅助方法
extension Position {
    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt(x*x + y*y)
    }
}
// 添加辅助方法后,
extension Ship {
    func canSafelyEngage2(ship target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange
            && targetDistance > unsafeRange
            && friendlyDistance > unsafeRange
    }
}

// 封装
fileprivate typealias Region = (Position) -> Bool

// 下面, 通过函数来创建控制和合并几个区域
// 定义一个区域: 以原点为圆心的圆
fileprivate func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}
// 如果我们想要更多图形组件
fileprivate func shift(_ region: @escaping Region, by offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}



//MARK: 这里, 没有抄完案例, 也没有弄懂, 感觉这个案例还是怪怪的😂

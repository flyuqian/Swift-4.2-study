//
//  TFChartController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFChartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}



// Size 的 w h * l
func *(l: CGFloat, r: CGSize) -> CGSize {
    return CGSize(width: l * r.width, height: l * r.height)
}
// Size 的 w h 分别*
func *(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width * r.width, height: l.height * r.height)
}
// Size的  w h 分别 -
func -(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width - r.width, height: l.height - r.height)
}
// Point 的 x y 分别 +
func +(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x + r.x, y: l.y + r.y)
}




enum Attribute {
    case fillColor(UIColor)
}

enum Primitive {
    case ellipse
    case rectangle
    case text(String)
}

indirect enum Diagram {
    case primitive(CGSize, Primitive)
    case beside(Diagram, Diagram)
    case below(Diagram, Diagram)
    case attributed(Attribute, Diagram)
    case align(CGPoint, Diagram)
}

extension Diagram {
    var size: CGSize {
        switch self {
        case .primitive(let size, _):
            return size
        case .attributed(_ , let x):
            return x.size
        case let .beside(l, r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: sizeL.width + sizeR.width, height: max(sizeL.height, sizeR.height))
        case let .below(l, r):
            return CGSize(width: max(l.size.width, r.size.width), height: l.size.height + r.size.height)
        case .align(_, let r):
            return r.size
        }
    }
}


extension CGSize {
    func fit(into rect: CGRect, alignment: CGPoint) -> CGRect {
        let scale = min(rect.width / width, rect.height / height)
        let targeSize = scale * self
        let spacerSize = alignment.size * (rect.size - targeSize)
        return CGRect(origin: rect.origin + spacerSize.point, size: targeSize)
    }
}



extension CGSize {
    var point: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
    
}
extension CGPoint {
    var size: CGSize { return CGSize(width: x, height: y) }
}

extension CGContext {
    func draw(_ primitive: Primitive, in frame: CGRect) {
        switch primitive {
        case .rectangle:
            fill(frame)
        case .ellipse:
            fillEllipse(in: frame)
        case .text(let text):
            let font = UIFont.systemFont(ofSize: 12)
            let attributes = [NSAttributedString.Key.font : font]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(in: frame)
        }
    }
}

extension CGRect {
    // 按照指定的比例和拆分方向, 将某个举行进行平行拆分
    func split(ratio: CGFloat, edge: CGRectEdge) -> (CGRect, CGRect) {
        let length = edge.isHorizontal ? width : height
        return divided(atDistance: length * ratio, from: edge)
    }
}
extension CGRectEdge {
    var isHorizontal: Bool {
        return self == .maxXEdge || self == .minXEdge
    }
}


func rect(width: CGFloat, height: CGFloat) -> Diagram {
    return .primitive(CGSize(width: width, height: height), .rectangle)
}
func circle(diameter: CGFloat) -> Diagram {
    return .primitive(CGSize(width: diameter, height: diameter), .ellipse)
}
func text(_ theText: String, width: CGFloat, height: CGFloat) -> Diagram {
    return .primitive(CGSize(width: width, height: height), .text(theText))
}
func square(side: CGFloat) -> Diagram {
    return rect(width: side, height: side)
}

precedencegroup HorizontalCombination {
    higherThan: VerticalCombination
    associativity: left
}
infix operator |||: HorizontalCombination

func |||(l: Diagram, r: Diagram) -> Diagram {
    return .beside(l, r)
}

precedencegroup VerticalCombination {
    associativity: left
}
infix operator ---: VerticalCombination
func ---(l: Diagram, r: Diagram) -> Diagram {
    return .below(l, r)
}



extension Diagram {
    func filled(_ color: UIColor) -> Diagram {
        return .attributed(.fillColor(color), self)
    }
    func aligned(to point: CGPoint) -> Diagram {
        return Diagram.align(point, self)
    }
}
extension CGPoint {
    static let bottom = CGPoint(x: 0.5, y: 1)
    static let top = CGPoint(x: 0.5, y: 1)
    static let center = CGPoint(x: 0.5, y: 0.5)
}
extension Diagram {
    init() {
        self = rect(width: 0, height: 0)
    }
}
extension Sequence where Iterator.Element == Diagram {
    var hcat: Diagram {
        return reduce(Diagram(), |||)
    }
}

extension CGContext {
    func draw(_ diagram: Diagram, in bounds: CGRect) {
        switch diagram {
        case let .primitive(size, primitive):
            let bounds = size.fit(into: bounds, alignment: .center)
            draw(primitive, in: bounds)
        
        case let .align(alignment, diagram):
            let bounds = diagram.size.fit(into: bounds, alignment: alignment)
            draw(diagram, in: bounds)
            
        case let .beside(left, right):
            let (lBounds, rBounds) = bounds.split(
                ratio: left.size.width / diagram.size.width, edge: .minXEdge)
            draw(left, in: lBounds)
            draw(right, in: rBounds)
            
        case .below(let top, let bottom):
            let (tBounds, bBounds) = bounds.split(
                ratio: top.size.height / diagram.size.height, edge: .minYEdge)
            draw(top, in: tBounds)
            draw(bottom, in: bBounds)
            
        case let .attributed(.fillColor(color), diagram):
            saveGState()
            color.set()
            draw(diagram, in: bounds)
            restoreGState()

        }
    }
}

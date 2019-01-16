//
//  TFInfunc02Controller.swift
//  TF01
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFInfunc02Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "封装 Core Image"
        view.backgroundColor = .white
        
        test01()
    }
    
    func test01() {
        // 测试颜色层叠和模糊组合
        let url = URL(string: "http://via.placeholder.com/500x500")!
        let image = CIImage(contentsOf: url)!
        
        let radius = 5.0
        let color = UIColor.red.withAlphaComponent(0.2)
        
        // 下面两种调用相同, 缺点是可读性差
        let blurImage = blur(radius: radius)(image)
        _ = overlay(color: color)(blurImage)
        
        _ = overlay(color: color)(blur(radius: radius)(image))
     
        // 使用 compose函数
        let blurAndOverlay = compose(filter: blur(radius: radius), with: overlay(color: color))
        _ = blurAndOverlay(image)
    }


}

// 将 Filter 类型定义为一个函数, 该函数接收一个图像作为参数, 返回一个新的图像
fileprivate typealias Filter = (CIImage) -> CIImage

// 高斯模糊, 参数为模糊半径
fileprivate func blur(radius: Double) -> Filter {
    return { image in
        let params: [String : Any] = [
            kCIInputRadiusKey : radius,
            kCIInputImageKey : image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", parameters: params) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}


// 颜色生成滤镜
fileprivate func generate(color: UIColor) -> Filter {
    return { _ in
        let params = [kCIInputColorKey : CIColor(cgColor: color.cgColor)]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", parameters: params) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}
// 合成滤镜
fileprivate func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let params = [kCIInputBackgroundImageKey : image,
                      kCIInputImageKey : overlay]
        guard let filter = CIFilter(name: "CISourceOverCompositing", parameters: params) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage.cropped(to: image.extent)
    }
}
// 颜色层叠
fileprivate func overlay(color: UIColor) -> Filter {
    return { image in
        let overlay = generate(color: color)(image).cropped(to: image.extent)
        return compositeSourceOver(overlay: overlay)(image)
    }
}

fileprivate func compose(filter filter1: @escaping Filter, with filter2: @escaping Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}
// 为了阅读方便, 我们可以加个compose 定义为操作符
//infix >>>
//func >>>(filter filter1: @escaping Filter, with filter2: @escaping Filter) -> Filter {
//    return { image in filter2(filter1(image)) }
//}
// 操作符 必须是全局的

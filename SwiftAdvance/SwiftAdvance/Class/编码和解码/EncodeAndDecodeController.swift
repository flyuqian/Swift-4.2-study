//
//  EncodeAndDecodeController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/9.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class EncodeAndDecodeController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
    }
    

   

}


// 将程序内部的数据结构序列化为一些可交换的数据格式, 以及将这些数据格式反序列化为内部使用的数据结构
extension EncodeAndDecodeController {
 
    // MARK: 概览
    // Codable
    // 普遍性: 适用于 类 结构体 枚举
    // 类型安全, 想JSON这样的可交换格式通常都是弱类型, 而你的代码应该使用强类型
    // 减少模板代码
    // Codable 是Decodable 和 Encodable 的组合
    // 标准库中 的Bool,数值类型, String等基本类型, 包含了Codable元素的可选值, 数组字典集合, Data, Date, URL, CGPoint, CGRect 都实现了Codable
    
    // 例子1
    func test1() {
        struct CoorDinate: Codable {
            var latitude: Double
            var longitude: Double
        }
        // 因为这个类型的 存储属性都是可编解码类型, 所以这个类型只需要声明协议即可
        struct PlaceMark: Codable {
            var name: String
            var coordinate: CoorDinate
        }
        
        // Swift 自带两个编码器, JSONEncoder PropertyListEncoder (fundation 而非 标准库)
        func test1() {
            let places = [
                PlaceMark(name: "Berlin", coordinate: CoorDinate(latitude: 52, longitude: 13)),
                PlaceMark(name: "Cape Town", coordinate: CoorDinate(latitude: -34, longitude: 18)),
            ]
            var jsonData: Data = Data.init()
            do {
                let encoder = JSONEncoder()
                jsonData = try encoder.encode(places)
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                print(jsonString)
                
            } catch {
                print(error.localizedDescription)
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([PlaceMark].self, from: jsonData)
                print(type(of: decoded))
                for place in decoded {
                    print("name: \(place.name), lat: \(place.coordinate.latitude), long: \(place.coordinate.longitude)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        test1()
    }
}




// MARK: 编码过程
extension EncodeAndDecodeController {

    // Encoder 的核心功能是提供一个编码容器, 容器的编码存储的是一种沙盒表现形式, 通过为每一个要编码的值创建一个新的容器, 编码器能够确保每个值都不会覆盖彼此的数据
    // 容器的类型
    /*
     - 键容器: 可以对键值对进行编码, 将键容器想象成一个特殊的字典, 到现在为止, 这是最常见的容器
     - 无键容器: 将对一系列的额值进行编码, 可以形象城编码值额数组
     - 单值容器: 对一个单一的值进行编码
     */
    // 对于这三种容器, 每个都对应了一个协议, 来定义容器应该如何接受一个值, 并进行编码
    
    // 值是如何对自己编码的
    //
    // 生成的代码
    // 编译器会生成一个叫做CodingKey的私有嵌套枚举类型
    
    
    
    
    // MARK: 手动遵守协议
    // 自定义 Coding Keys
    func test2() {
        
        struct CoorDinate: Codable {
            var latitude: Double
            var longitude: Double
        }
        
        struct PlaceMark: Codable {
            var name: String
            var coordinate: CoorDinate
            
            private enum CodingKeys: String, CodingKey {
                case name = "label"
                case coordinate
            }
            // 如果, 自定义了 CodingKeys, 而CodingKeys中没有某一个属性, 那么该属性将不会被编码
            // 上面, name有默认值, 若没有默认值,Decodable所生成的代码将会编译失败, 因为编译器会发现再初始化方法中无法为其赋值
        }
        
        // 自定义的 encode(to:) 和 init(from:) 实现
        // 如果你需要更多地控制, 你还可以对 encode(to:) 和/或 init(from:)进行自己的实现
        // JSONEncoder 和 JSONDecoder 默认可以处理可选值, 如果目标类型中的一个目标属性是可选值, 如果输入数据中对应的值不存在, 编译器将会正确的跳过这个属性
        struct PlaceMark4: Codable {
            var name: String
            var coordinate: CoorDinate?
        }
        let validJSONInput = """
            [
            {"name" : "Berlin"},
            {"name" : "Cpe Town"}
            ]
            """
        // 不过 JSONDecoder 对输入数据十分挑剔, 只要数据和所期待的形式稍有不同, 就有可能出发错误
    }

}

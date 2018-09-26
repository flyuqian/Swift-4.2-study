//
//  CodableController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 加入Codable协议, 用来处理序列化和反序列化
// 再利用 JSONEncoder 和 JSONDecoder 进行 json解析
// 只要一个类型中所有的成员都实现了 Codable, name这个类型自动满足 Codable
// 标准库中, String, Int, Double, Date, URL 这样的类型默认实现了 Codable
// 如果 JSON中的key和类型中的变量名不一致的话, 我们需要在对应类型中声明 CodingKeys 枚举, 并用合适的健值覆盖对应的默认值
import UIKit

class CodableController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let jsonString = """
                    {"menu": {
                        "id": "file",
                        "value": "File",
                        "popup": {
                            "menuitem": [
                            {"value": "New", "onclick": "CreateNewDoc()"},
                            {"value": "Open", "onclick": "OpenDoc()"},
                            {"value": "Close", "onclick": "CloseDoc()"}
                            ]
                        }
                        }}
                    """

        struct Obj: Codable {
            let menu: Menu
            
            struct Menu: Codable {
                let id: String
                let value: String
                let popup: Popup
            }
            
            struct Popup: Codable {
                let menuItem: [MenuItem]
                
                enum CodingKeys: String, CodingKey {
                    case menuItem = "menuitem"
                }
            }
            
            struct MenuItem: Codable {
                let value: String
                let onClick: String
                
                enum CodingKeys: String, CodingKey {
                    case value
                    case onClick = "onclick"
                }
            }
        }

        guard let data = jsonString.data(using: .utf8) else { print("data warning"); return }
        
        do {
            let obj = try JSONDecoder().decode(Obj.self, from: data)
            let value = obj.menu.popup.menuItem[0].value
            print(value)
        }
        catch (let error) {
            print("decode faile, Error: \(error)")
        }
    }
    


}

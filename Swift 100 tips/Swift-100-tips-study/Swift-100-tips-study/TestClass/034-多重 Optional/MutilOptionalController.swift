//
//  MutilOptionalController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Optional 的实现
//        enum Optional<T> : _Reflectable, NilLiteralConvertible {
//            case None
//            case Some(T)
//        }
// 泛型 T 没有限制, 我们可以在Optional中装入任何东西, 包括Optional


import UIKit

class MutilOptionalController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }
    
    func test() {
        var string: String? = "string"
        var anoterString: String?? = string
        // anoterString 是一个Optional<Optional<String>> 的值
        // 我们可以 直接赋值 字面量
        var literalOptional: String?? = "string"
        // 这种情况, 类型推断我们只能将 Optional<String> 放入到 literalOptional中, 所以可以猜测它与 anoterString 等效
        // 如果将 nil 赋值给他
        var aNil: String? = nil
        var anotherNil: String?? = aNil
        var literaNil: String?? = nil
        // anoterNil 和 literaNil 是否等效?
        // 不等效
        // 测试
        if anotherNil != nil {
            print("anotherNil")
        }
        if literaNil != nil {
            print("literaNil")
        }
        // 只能输出 anotherNil
        
        // 使用 fr v -R 命令调试
        // fr v -R anoterNil
        
        /*
         
         
         

        (lldb) fr v -R anotherNil
        (Swift.Optional<Swift.Optional<Swift.String>>) anotherNil = some {
            some = none {
                some = {
                    _core = {
                        _baseAddress = none {
                            some = {
                                _rawValue = 0x0000000000000000
                            }
                        }
                        _countAndFlags = {
                            _value = 0
                        }
                        _owner = none {
                            some = {
                                instance_type = 0x0000000000000000
                            }
                        }
                    }
                }
            }
        }
        (lldb) fr v -R literaNil
        (Swift.Optional<Swift.Optional<Swift.String>>) literaNil = none {
            some = some {
                some = {
                    _core = {
                        _baseAddress = none {
                            some = {
                                _rawValue = 0x0000000000000000
                            }
                        }
                        _countAndFlags = {
                            _value = 0
                        }
                        _owner = none {
                            some = {
                                instance_type = 0x0000000000000000
                            }
                        }
                    }
                }
            }
        }
        (lldb)
          */
    }
}

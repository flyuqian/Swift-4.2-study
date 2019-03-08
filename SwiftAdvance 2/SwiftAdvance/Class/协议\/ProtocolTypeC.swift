//
//  ProtocolTypeC.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2019/2/28.
//  Copyright © 2019 com.test. All rights reserved.
//

import UIKit

class ProtocolTypeC: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   
}

// 带有关联类型的协议, 在协议定义中使用了 Self的协议, 和普通的协议不同, 这样的协议不能当做单独的类型使用
struct ConstantIterator: IteratorProtocol {
    mutating func next() -> Int? {
        return 1
    }
}
/*
 protocol Collection: _Indexable, Sequence {
 associatedtype IndexDistance = Int
 associatedtype Iterator: IteratorProtocol = IndexingIterator<Self>
 // ... 方法定义以及更多的关联类型
 }
 
 */

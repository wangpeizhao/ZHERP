//
//  Common-Extensions.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/22.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

extension Array {
    //删除选中的数据
//    items.removeAt(indexes:selectedIndexs)
    //Array方法扩展，支持根据索引数组删除
    mutating func removeAt(indexes: [Int]) {
        for i in indexes.sorted(by: >) {
            self.remove(at: i)
        }
    }
}

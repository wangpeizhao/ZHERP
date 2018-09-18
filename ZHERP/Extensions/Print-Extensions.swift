//
//  Print-Extensions.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/18.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import Foundation

//class func propertyList() -> [String] {
//    var count: UInt32 = 0
//    //获取类的属性列表,返回属性列表的数组,可选项
//    let list = class_copyPropertyList(self, &count)
//    print("属性个数:\(count)")
//    //遍历数组
//    for i in 0..<Int(count) {
//        //根据下标获取属性
//        let pty = list?[i]
//        //获取属性的名称<C语言字符串>
//        //转换过程:Int8 -> Byte -> Char -> C语言字符串
//        let cName = property_getName(pty!)
//        //转换成String的字符串
//        let name = String(utf8String: cName!)
//        print(name!)
//    }
//    free(list) //释放list
//    return []
//}

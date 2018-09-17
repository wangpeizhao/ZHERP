//
//  UIResponder-Extensions.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/17.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

private weak var zh_TextfieldFirstResponder: UITextField?

extension UIResponder {
    
    static func getTextfieldFirstResponder() -> UITextField? {
        zh_TextfieldFirstResponder = nil
        // 通过将target设置为nil，让系统自动遍历响应链
        // 从而响应链当前第一响应者响应我们自定义的方法
        UIApplication.shared.sendAction(#selector(_findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return zh_TextfieldFirstResponder
    }
    
    @objc func _findFirstResponder(_ sender: UITextField) {
        // 第一响应者会响应这个方法，并且将静态变量zh_TextfieldFirstResponder设置为自己
        zh_TextfieldFirstResponder = self as? UITextField
    }
}

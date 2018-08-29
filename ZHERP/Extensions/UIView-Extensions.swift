//
//  UIView-Extensions.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/2.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit


//删除一个view 下的所有子view
//extension UIView {
//
//    func clearAll(){
//
//        if self.subviews.count >0 {
//
//            self.subviews.forEach({ $0.removeFromSuperview()});
//
//            // xcode7会提示 Result of call to map is unused
//
//            //self.subviews.map { $0.removeFromSuperview()};
//
//        }
//
//    }
//
//}

extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}

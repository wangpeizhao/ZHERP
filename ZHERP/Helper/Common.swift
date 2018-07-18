//
//  Common.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

public func getIOSVersion() -> Int{
    // 获取系统版本号
    let sysVersion = UIDevice.current.systemVersion
    return Int(sysVersion.components(separatedBy: ".").first!)!
}

public func _dismiss(view: UIViewController) {
    view.dismiss(animated: true, completion: nil)
}

public func _confirm(view: UIViewController, title: String, message: String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    let DestructiveAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.destructive) {
        (result : UIAlertAction) -> Void in
        print("Destructive")
    }
    
    let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) {
        (result : UIAlertAction) -> Void in
        print("OK")
    }
    
    alertController.addAction(DestructiveAction)
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}

public func _login(view: UIViewController) {
    let vc = LoginViewController()
    view.present(vc, animated: true, completion: nil)
}

public func _open(view: UIViewController, target: UIViewController) {
    // 方法1
//    let vc = view.storyboard?.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
//    view.present(vc, animated: true, completion: nil)
    
    // 方法2
    // let vc = MemberViewController()
    // self.present(vc, animated: true, completion: nil)
    
    // 方法3
    // let sb = UIStoryboard(name: "Main", bundle:nil)
    // let vc = sb.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
    // self.present(vc, animated: true, completion: nil)
}

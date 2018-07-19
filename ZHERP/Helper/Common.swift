//
//  Common.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
var userDefault:UserDefaults!

public func getIOSVersion() -> Int{
    // 获取系统版本号
    let sysVersion = UIDevice.current.systemVersion
    return Int(sysVersion.components(separatedBy: ".").first!)!
}

public func _dismiss(view: UIViewController) {
    view.dismiss(animated: true, completion: {
        print("Had gone back.")
    })
}

func _alert(view: UIViewController, message: String) {
    let action = UIAlertAction(title: "确定", style: .default, handler: nil)
    let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alertViewController.addAction(action)
    view.present(alertViewController, animated: true, completion: nil)
}


public func _confirm(view: UIViewController, title: String, message: String, handler: ((UIAlertAction)->Void)?){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    let DestructiveAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) {
        (result : UIAlertAction) -> Void in
        print("Destructive")
    }
    
    let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: handler)
    
    alertController.addAction(DestructiveAction)
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}

public func _login() {
    userDefault.set(true, forKey: "LoginStatus")
}

public func _logout() {
    userDefault.set(false, forKey: "LoginStatus")
}

// 登录状态
public func checkLoginStatus() -> Bool{
    userDefault = UserDefaults.standard
    guard userDefault.bool(forKey: "LoginStatus") else {
        return false
    }
    return true
}

// 根据登录状态跳转页面
public func checkLogin(view: UIViewController){
    let status: Bool = checkLoginStatus()
    let vc: UIViewController?
    if(!status) {
        vc = view.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        _open(view: view, vc: vc!)
    }
}

public func _open(view: UIViewController, vc: UIViewController) {
    let nav = UINavigationController(rootViewController: vc)
    let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
    //set title color
    nav.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
    
    view.present(nav, animated: true, completion: nil)
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
    // 黑屏
    //        let vc = LoginViewController()
    //        let nav = UINavigationController(rootViewController: vc)
    //        self.present(nav, animated: true, completion: nil)
    
    // 正常
    //        let sb = UIStoryboard(name: "Main", bundle:nil)
//    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//    _open(view: self, vc: vc)
    //
    //        self.showDetailViewController(vc, sender: vc)
    //        self.show(nav, sender: LoginViewController.self)
    
    // 正常
    //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    //        self.present(vc, animated: true, completion: nil)
    
    // 没反应
    //        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    
    // 黑屏
    //        self.present(LoginViewController(), animated: true, completion: nil)
}

public func setBackBtn(view: UIViewController, selector: Selector) {
    let leftBtn: UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: view, action: selector)
    leftBtn.title = "返回";
    leftBtn.tintColor = Specs.color.white
    view.navigationItem.leftBarButtonItem = leftBtn;
}

public func setNavBarTitle(view: UIViewController, title: String) {
    view.navigationItem.title = title
    view.navigationController?.navigationBar.barTintColor = Specs.color.tint
    view.navigationController?.navigationBar.tintColor = Specs.color.white
    view.navigationItem.leftItemsSupplementBackButton = true
}

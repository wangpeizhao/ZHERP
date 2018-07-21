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
    print("_logout")
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
    if(!status) {
        _open(view: view, vcName: "login", withNav: false)
    }
}

public func _open(view: UIViewController, vcName: String = "login", withNav: Bool = true) {
    guard !vcName.isEmpty else {
        return
    }
    let vc: UIViewController!
    switch vcName {
    case "login":
        vc = view.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        break
    case "register":
        vc = view.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        break
    case "home":
        vc = view.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        break
    case "member":
        vc = view.storyboard?.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
        break
    case "forget":
        vc = view.storyboard?.instantiateViewController(withIdentifier: "ForgotPwdViewController") as! ForgotPwdViewController
        break
    case "resetPwd":
        vc = view.storyboard?.instantiateViewController(withIdentifier: "ResetPwdViewController") as! ResetPwdViewController
        break
    default:
        _logout()
        vc = view.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        break
    }
    _open(view: view, vc: vc, withNav: withNav)
}

public func _open(view: UIViewController, vc: UIViewController, withNav: Bool = true) {
    if(withNav) {
        let nav = UINavigationController(rootViewController: vc)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        //set title color
        nav.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        view.present(nav, animated: true, completion: nil)
    } else {
        view.present(vc, animated: true, completion: nil)
    }
    
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

public func setBackBtn(view: UIViewController, selector: Selector, title: String = "返回", parent: Bool = false) {
    let backBtn: UIBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: view, action: selector)
    
    if parent {
        // 父类设置有文字并保留箭头
        view.navigationItem.backBarButtonItem = backBtn
    } else {
        // 返回按钮文字颜色
        backBtn.tintColor = Specs.color.white
        // 子页面设置时 没箭头
        view.navigationItem.leftBarButtonItem = backBtn
    }
}

public func setNavBarTitle(view: UIViewController, title: String, transparent: Bool = false) {
    view.navigationItem.title = title
    // 设置导航标题颜色
    view.navigationController?.navigationBar.tintColor = Specs.color.white
    
    if transparent != false {
        // 设置导航背景透明
        view.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
        return
    }
    // 设置导航背景颜色
    view.navigationController?.navigationBar.barTintColor = Specs.color.main
    view.navigationItem.leftItemsSupplementBackButton = true
}

func setUITextFileBP(textFiled: UITextField, placeholder: String) {
    // 设置下划线边框
    let border = CALayer()
    let width = CGFloat(1.0)
    let y = textFiled.frame.size.height - width
    border.borderColor = UIColor.white.cgColor
    border.frame = CGRect(x: 0, y: y, width: textFiled.frame.size.width, height: textFiled.frame.size.height)
    border.borderWidth = width
    textFiled.layer.addSublayer(border)
    textFiled.layer.masksToBounds = true
    
    // 设置占位符颜色和字体大小
    let placeholserAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: setFontSize()]
    textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholserAttributes)
    textFiled.backgroundColor = UIColor.clear
}

func setFontSize(size: CGFloat = 15) -> UIFont{
    return UIFont.systemFont(ofSize: size, weight: .light)
}

func setUIButtonToCircle(button: UIButton, radius: CGFloat = 32.0) {
    button.layer.borderWidth = Specs.border.width * 2
    button.layer.borderColor = Specs.color.blue.cgColor
    button.layer.cornerRadius = radius
    button.layer.masksToBounds = true
    button.frame.size = CGSize(width: radius * 2, height: radius * 2)
}



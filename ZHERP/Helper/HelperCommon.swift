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

public func _tip(view: UIViewController, title: String = "保存成功!") {
    let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    //显示提示框
    view.present(alertController, animated: true, completion: nil)
    //两秒钟后自动消失
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
        view.presentedViewController?.dismiss(animated: false, completion: nil)
    }
}

//https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
func _alert(view: UIViewController, message: String, handler: ((UIAlertAction)->Void)? = nil) {
    let action = UIAlertAction(title: "确定", style: .default, handler: handler)
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
        return true
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

public func _close(view: UIViewController) {
    _dismiss(view: view)
}

public func _back(view: UIViewController, root: Bool = false) {
    if root {
        view.navigationController?.popToRootViewController(animated: true)
    } else {
        view.navigationController?.popViewController(animated: true)
    }
}

public func _back(view: UIViewController, target: UIViewController) {
    view.navigationController?.popToViewController(target, animated: true)
}

public func _push(view: UIViewController, target: UIViewController, rootView: Bool = true) {
//    let viewCount = view.childViewControllers.count
//    if viewCount >= 1 {
//        view.hidesBottomBarWhenPushed = true
//    }
    
    view.hidesBottomBarWhenPushed = true
    view.navigationController?.pushViewController(target, animated: true)
    if rootView {
        view.hidesBottomBarWhenPushed = false
    }
    
//    if viewCount >= 1 {
//        view.hidesBottomBarWhenPushed = false
//    }
    // 返回到上一个界面
//    self.navigationController?.popViewControllerAnimated(true)
}

public func _open(view: UIViewController, vcName: String = "login", withNav: Bool = true) {
    guard !vcName.isEmpty else {
        return
    }
    let vc: UIViewController!
    let sb = UIStoryboard(name: "Main", bundle:nil)
    // view.storyboard?.instantiateViewController
    switch vcName {
    case "login":
        vc = sb.instantiateViewController(withIdentifier: "LoginingViewController") as! LoginingViewController
        break
    case "register":
        vc = sb.instantiateViewController(withIdentifier: "RegisteringViewController") as! RegisteringViewController
        break
    case "home":
        vc = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        break
    case "member":
        vc = sb.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
        break
    case "forget":
        vc = sb.instantiateViewController(withIdentifier: "ForgetViewController") as! ForgetViewController
        break
    case "resetPwd":
        vc = sb.instantiateViewController(withIdentifier: "ResetViewController") as! ResetViewController
        break
    case "system":
        vc = sb.instantiateViewController(withIdentifier: "SystemViewController") as! SystemViewController
        break
    case "setting":
        vc = sb.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        break
    case "personal":
        vc = sb.instantiateViewController(withIdentifier: "PersonalViewController") as! PersonalViewController
        break
    case "search":
        vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        break
    default:
        _logout()
        vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
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
//    
//    let miaoSB = UIStoryboard(name:"Miao",bundle:nil)
//    let miaoVC = miaoSB.instantiateInitialViewController()
//    UIApplication.shared.keyWindow?.rootViewController = miaoVC
//    
//    let loginSB = UIStoryboard(name:"Login",bundle:nil)
//    let loginVC = loginSB.instantiateInitialViewController()
//    miaoVC?.present(loginVC!, animated: false, completion: nil)
//    
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

public func setNavBarTitle(view: UIViewController, title: String, transparent: Bool = false, ofSize: CGFloat = 18) {
    //    let arr=UIFont.familyNames
    //    print(arr)
    //    ["Copperplate", "Heiti SC", "Apple SD Gothic Neo", "Thonburi", "Gill Sans", "Marker Felt", "Hiragino Maru Gothic ProN", "Courier New", "Kohinoor Telugu", "Heiti TC", "Avenir Next Condensed", "Tamil Sangam MN", "Helvetica Neue", "Gurmukhi MN", "Georgia", "Times New Roman", "Sinhala Sangam MN", "Arial Rounded MT Bold", "Kailasa", "Kohinoor Devanagari", "Kohinoor Bangla", "Chalkboard SE", "Apple Color Emoji", "PingFang TC", "Gujarati Sangam MN", "Geeza Pro", "Damascus", "Noteworthy", "Avenir", "Mishafi", "Academy Engraved LET", "Futura", "Party LET", "Kannada Sangam MN", "Arial Hebrew", "Farah", "Arial", "Chalkduster", "Kefa", "Hoefler Text", "Optima", "Palatino", "Malayalam Sangam MN", "Al Nile", "Lao Sangam MN", "Bradley Hand", "Hiragino Mincho ProN", "PingFang HK", "Helvetica", "Courier", "Cochin", "Trebuchet MS", "Devanagari Sangam MN", "Oriya Sangam MN", "Rockwell", "Snell Roundhand", "Zapf Dingbats", "Bodoni 72", "Verdana", "American Typewriter", "Avenir Next", "Baskerville", "Khmer Sangam MN", "Didot", "Savoye LET", "Bodoni Ornaments", "Symbol", "Charter", "Menlo", "Noto Nastaliq Urdu", "Bodoni 72 Smallcaps", "DIN Alternate", "Papyrus", "Hiragino Sans", "PingFang SC", "Myanmar Sangam MN", "Zapfino", "Telugu Sangam MN", "Bodoni 72 Oldstyle", "Euphemia UCAS", "Bangla Sangam MN", "DIN Condensed"]
    //设置UINavigationBar title的字体和颜色
//    let titleTextAttributes :[String : AnyObject] = [NSFontAttributeName : UIFont(name: "Helvetica", size: 22) as! AnyObject , NSForegroundColorAttributeName : UIColor(red: 0.2392, green: 0.7137, blue: 0.7451, alpha: 1) as AnyObject]
//    UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
    //UITabBar bar 的选中颜色
//    UITabBar.appearance().tintColor = UIColor(red: 0.2392, green: 0.7137, blue: 0.7451, alpha: 1)
    //tabbar默认的背景色
//    UITabBar.appearance().barTintColor = UIColor.clearColor()
    
    view.navigationItem.title = title
    // 修改导航栏标题颜色、修改导航栏标题字体和大小
    view.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: ofSize)]
//    view.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont(name: "Bobz Type", size: 20) as Any]
    
    // 设置导航背景透明
    if transparent != false {
        view.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
        view.navigationController?.navigationBar.isTranslucent = true
        return
    }
    // 设置导航背景颜色
//    view.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 186/255, blue: 89/255, alpha: 1)
    view.navigationController?.navigationBar.barTintColor = Specs.color.main
    view.navigationItem.leftItemsSupplementBackButton = true
}

// 修改“返回按钮”图标 (需要图片也需要文字)
public func setNavBarImageBtn(view: UIViewController, selector: Selector) {
    let button = UIButton(type: .system)
    button.frame = CGRect(x:0, y:0, width:65, height:30)
    button.setImage(UIImage(named:"userinfo-icon"), for: .normal)
    button.setTitle("返回", for: .normal)
    button.addTarget(view, action: selector, for: .touchUpInside)
    let leftBarBtn = UIBarButtonItem(customView: button)
    //用于消除左边空隙，要不然按钮顶不到最前面
    let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    spacer.width = -10;
    view.navigationItem.leftBarButtonItems = [spacer,leftBarBtn]
}

public func setNavBarBackBtn(view: UIViewController, title: String, selector: Selector) {
    let backBtn = UIBarButtonItem(title: title, style: .plain, target: view, action: selector)
    // 返回按钮文字颜色
    backBtn.tintColor = Specs.color.white
    view.navigationItem.backBarButtonItem = backBtn
}

public func setNavBarLeftBtn(view: UIViewController, title: String, selector: Selector) {
    let leftBtn = UIBarButtonItem(title: title, style: .plain, target: view, action: selector)
    // 返回按钮文字颜色
    leftBtn.tintColor = Specs.color.white
    view.navigationItem.leftBarButtonItem = leftBtn
}

// https://blog.csdn.net/lwjok2007/article/details/48375717
public func setNavBarRightBtn(view: UIViewController, title: String, selector: Selector, color: UIColor = Specs.color.white) {
    let rightBtn = UIBarButtonItem(title: title, style: .plain, target: view, action: selector)
    // 返回按钮文字颜色
    rightBtn.tintColor = color
//    self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Your Font", size: 34)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    view.navigationItem.rightBarButtonItem = rightBtn
}

public func setNavBar(view: UIViewController, title: String, backBtnTitle: String, backBtnSelector: Selector, leftBtnTitle: String, leftBtnSelector: Selector, rightBtnTitle: String, rightBtnSelector: Selector) {
    setNavBarTitle(view: view, title: title)
    setNavBarBackBtn(view: view, title: backBtnTitle, selector: backBtnSelector)
    setNavBarLeftBtn(view: view, title: leftBtnTitle, selector: leftBtnSelector)
    setNavBarRightBtn(view: view, title: rightBtnTitle, selector: rightBtnSelector)
}

public func setButtonCommon(button: UIButton, title: String, isEnabled: Bool = true) {
    button.setTitle(title, for: UIControlState())
    button.setTitleColor(Specs.color.white, for: UIControlState())
    button.layer.cornerRadius = Specs.border.radius
    button.layer.masksToBounds = true
    button.backgroundColor = Specs.color.btnBg
    button.isEnabled = isEnabled
}

func setUITextFieldBP(textFiled: UITextField, placeholder: String) {
    // 设置下划线边框
    let border = CALayer()
    let width = Specs.border.width
    let y = textFiled.frame.size.height - width
    border.borderColor = UIColor.white.cgColor
    border.frame = CGRect(x: 0, y: y, width: textFiled.frame.size.width, height: textFiled.frame.size.height)
    border.borderWidth = width
    textFiled.layer.addSublayer(border)
    textFiled.layer.masksToBounds = true
    textFiled.borderStyle = UITextBorderStyle.none
    
    // 设置占位符颜色和字体大小
    let placeholserAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: setFontSize()]
    textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholserAttributes)
    textFiled.backgroundColor = UIColor.clear
    
    // 设置控件属性
//    textFiled.font = UIFont(name: "Chalkduster", size: Specs.fontSize.regular)
    //文字编辑的时候现实清除按钮。默认不显示
    textFiled.clearButtonMode = UITextFieldViewMode.whileEditing
    
//    textFiled.returnKeyType = UIReturnKeyType.go
    
}

func setTextFieldCommonFeatures(textFiled: UITextField, width: CGFloat = 44, height: CGFloat = 44) {
    textFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    textFiled.leftViewMode = UITextFieldViewMode.always
    textFiled.returnKeyType = UIReturnKeyType.next
    textFiled.textColor = Specs.color.white
    textFiled.clearButtonMode = UITextFieldViewMode.whileEditing
}

func setTextFieldPlaceholser(textFiled: UITextField, placeholder: String) {
    // 设置占位符颜色和字体大小
    let placeholserAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: setFontSize()]
    textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholserAttributes)
    textFiled.backgroundColor = UIColor.clear
}

func setTextFieldBottomLine(textFiled: UITextField) {
    // 设置下划线边框
    let border = CALayer()
    let width = Specs.border.width
    let y = textFiled.frame.size.height - width
    border.borderColor = UIColor.white.cgColor
    border.frame = CGRect(x: 0, y: y, width: textFiled.frame.size.width, height: textFiled.frame.size.height)
    border.borderWidth = width
    textFiled.layer.addSublayer(border)
    textFiled.layer.masksToBounds = true
    textFiled.borderStyle = UITextBorderStyle.none
}

func setViewWidgetBottomLine(widget: UIView) {
    // 设置下划线边框
    let border = CALayer()
    let width = Specs.border.width
    let y = widget.frame.size.height - width
    border.borderColor = UIColor.black.cgColor
    border.frame = CGRect(x: 0, y: y, width: widget.frame.size.width, height: widget.frame.size.height)
    border.borderWidth = width
    widget.layer.addSublayer(border)
    widget.layer.masksToBounds = true
}

func setFontSize(size: CGFloat = 15) -> UIFont{
    return UIFont.systemFont(ofSize: size, weight: .light)
}

func setUIButtonToCircle(button: UIButton, radius: CGFloat = 32.0) {
    button.layer.borderWidth = Specs.border.width * 2
    button.layer.borderColor = Specs.color.circle.cgColor
    button.layer.cornerRadius = radius
    button.layer.masksToBounds = true
    button.frame.size = CGSize(width: radius * 2, height: radius * 2)
}

func imageAdaptive(imageView: UIImageView, imageName: String) {
    //内容图片的宽高比约束
    var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                imageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                imageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    if let image = UIImage(named: imageName) {
        //计算原始图片的宽高比
        let aspect = image.size.width / image.size.height
        //设置imageView宽高比约束
        aspectConstraint = NSLayoutConstraint(item: imageView,
                                              attribute: .width, relatedBy: .equal,
                                              toItem: imageView, attribute: .height,
                                              multiplier: aspect, constant: 0.0)
        //加载图片
        imageView.image = image
    }else{
        //去除imageView里的图片和宽高比约束
        aspectConstraint = nil
        imageView.image = nil
    }
}


// 监听键盘通知
//NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

//监听键盘的事件
//func keyboardWillChangeFrame(note: Notification) {
//    
//    print(note.userInfo ?? "")
//    // 1.获取动画执行的时间
//    let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
//    
//    // 2.获取键盘最终 Y值
//    let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//    let y = endFrame.origin.y
//    
//    //计算工具栏距离底部的间距
//    let margin = UIScreen.main.bounds.height - y
//    print(margin)
//    // 更新约束,执行动画
//    toolBarBottom.snp.updateConstraints { (make) in
//        make.left.equalTo(0)
//        make.right.equalTo(0)
//        make.height.equalTo(44)
//        make.bottom.equalTo(-margin)
//    }
//    UIView.animate(withDuration: duration) {
//        self.view.layoutIfNeeded()
//    }
//}

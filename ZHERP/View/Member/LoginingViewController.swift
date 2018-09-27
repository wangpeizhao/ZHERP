//
//  LoginingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/28.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginingViewController: UIViewController, UITextFieldDelegate {
    
    var formView: UIView! //
    var titleLabel: UILabel! //
    var usernameTxt: UITextField!
    var passwordTxt: UITextField!
    
    var registerBtn: UIButton!
    var loginBtn: UIButton!
    
    var hasAccount: UILabel!
    var forgetBtn: UIButton!
    
    var topConstraint: Constraint? //Form框距顶部距离约束
    
    var CV: CGFloat = 40 // Common Value
    
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //视图背景色
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"LoginRegisterBg")!) // Specs.color.main
        //计算视图比例
        let ratio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        //根据比例裁剪出背景图
        let image = UIImage(named: "LoginRegisterBg")?.crop(ratio: ratio)
        //设置当前视图背景
        self.view.layer.contents = image?.cgImage
        
        // 多人icon
        let multiplayer = UIImageView()
        multiplayer.image = UIImage(named: "iconfont-multiplayer")
        self.view.addSubview(multiplayer)
        multiplayer.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(40)
            make.centerX.equalTo(self.view)
        }
        
        //标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = "纵横ERP - 登录"
        self.titleLabel.textColor = Specs.color.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(multiplayer.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        
        // Form
        let formViewHeight = 230
        self.formView = UIView()
        self.formView.layer.borderWidth = 0
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.CV/2)
            make.right.equalTo(self.CV/2 * -1)
            make.height.equalTo(formViewHeight)
            self.topConstraint = make.centerY.equalTo(self.view).offset(-50).constraint
        }
        
        // User Icon
        let usernameIcon = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        usernameIcon.image = UIImage(named: "iconfont-user")
        
        // Password Icon
        let passwordIcon = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        passwordIcon.image = UIImage(named: "iconfont-password")
        
        // Username Field
        self.usernameTxt = UITextField()
//        self.usernameTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.usernameTxt)
        setTextFieldPlaceholser(textFiled: self.usernameTxt, placeholder: "请输入手机号码")
        self.usernameTxt.tag = 100
        //输入框左侧图标
        self.usernameTxt.leftView?.addSubview(usernameIcon)
        self.usernameTxt.keyboardType = UIKeyboardType.phonePad
        self.formView.addSubview(self.usernameTxt)
        self.usernameTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.formView.snp.top).offset(5)
        }
        // Separator
        let SeparatorU = UILabel()
        SeparatorU.backgroundColor = Specs.color.white
        self.formView.addSubview(SeparatorU)
        SeparatorU.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self.usernameTxt)
            make.left.equalTo(self.usernameTxt.snp.left)
            make.height.equalTo(0.5)
            make.top.equalTo(self.usernameTxt.snp.bottom)
        }
        
        // Password Field
        self.passwordTxt = UITextField()
//        self.passwordTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.passwordTxt)
        setTextFieldPlaceholser(textFiled: self.passwordTxt, placeholder: "请输入密码(6~16位数字+字母)")
        self.passwordTxt.tag = 101
        //输入框左侧图标
        self.passwordTxt.leftView?.addSubview(passwordIcon)
        self.passwordTxt.keyboardType = UIKeyboardType.asciiCapable
        self.passwordTxt.isSecureTextEntry = true
        self.passwordTxt.returnKeyType = UIReturnKeyType.done
        self.formView.addSubview(self.passwordTxt)
        self.passwordTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.usernameTxt.snp.bottom).offset(20)
        }
        
        // Separator
        let SeparatorP = UILabel()
        SeparatorP.backgroundColor = Specs.color.white
        self.formView.addSubview(SeparatorP)
        SeparatorP.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self.passwordTxt)
            make.left.equalTo(self.passwordTxt.snp.left)
            make.height.equalTo(0.5)
            make.top.equalTo(self.passwordTxt.snp.bottom)
        }
        
        // Login Button
        self.loginBtn = UIButton()
        setButtonCommon(button: self.loginBtn, title: "登录", isEnabled: true)
        self.loginBtn.addTarget(self, action: #selector(loginBtnClicked(_:)), for: .touchUpInside)
        self.formView.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(self.passwordTxt.snp.bottom).offset(30)
            make.height.equalTo(self.CV)
        }
        
        // Register Button
        self.registerBtn = UIButton()
        self.registerBtn.setTitle("注册", for: UIControlState())
        self.registerBtn.setTitleColor(Specs.color.main, for: UIControlState())
        self.registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.registerBtn.addTarget(self, action: #selector(registerBtnClicked(_:)), for: .touchUpInside)
        self.formView.addSubview(self.registerBtn)
        self.registerBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.loginBtn)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        // Have account
        self.hasAccount = UILabel()
        self.hasAccount.text = "没有账号？"
        self.hasAccount.textColor = Specs.color.white
        self.hasAccount.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.formView.addSubview(self.hasAccount)
        self.hasAccount.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.registerBtn.snp.left).offset(-5)
            make.top.equalTo(self.registerBtn)
            make.height.equalTo(self.registerBtn)
        }
        
        // Forget password
        self.forgetBtn = UIButton()
        self.forgetBtn.setTitle("忘记密码？", for: UIControlState())
        self.forgetBtn.setTitleColor(Specs.color.main, for: UIControlState())
        self.forgetBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.forgetBtn.addTarget(self, action: #selector(forgetBtnClicked(_:)), for: .touchUpInside)
        self.formView.addSubview(self.forgetBtn)
        self.forgetBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.loginBtn)
            make.top.equalTo(self.registerBtn)
            make.height.equalTo(self.registerBtn)
        }
        
//        setTextFieldBottomLine(textFiled: self.usernameTxt)
//        setTextFieldBottomLine(textFiled: self.passwordTxt)
        
        
//        let registerVM = RegisterVM()
//
//        usernameTxt.rx.text.orEmpty
//            .bind(to: registerVM.username)
//            .disposed(by: disposeBag)
//
//        passwordTxt.rx.text.orEmpty
//            .bind(to: registerVM.password)
//            .disposed(by: disposeBag)
//
//        registerBtn.rx.tap
//            .bind(to: registerVM.registerTaps)
//            .disposed(by: disposeBag)
//
//        registerVM.usernameUseable
//            .bind(to: passwordTxt.rx.inputEnabled)
//            .disposed(by: disposeBag)
//
//        registerVM.registerButtonEnabled
//            .subscribe(onNext: { [unowned self] valid in
//                self.registerBtn.isEnabled = valid
//                self.registerBtn.alpha = valid ? 1.0 : 0.5
//            })
//            .disposed(by: disposeBag)
//
//        registerVM.registerResult
//            .subscribe(onNext: { [unowned self] result in
//                switch result {
//                case let .ok(message):
//                    self.loginSuccess(message: message)
//                case .empty:
//                    _alert(view: self, message: "")
//                case let .failed(message):
//                    _alert(view: self, message: message)
//                }
//            })
//            .disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
        
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        view.endEditing(true)
//    }
    // 收起键盘
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    @objc func forgetBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "forget", withNav: false)
    }
    @objc func registerBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "register", withNav: false)
    }
    @objc func loginBtnClicked(_ sender: Any) {
        print("loginBtnClicked")
//        guard self.usernameTxt.text != "" && self.passwordTxt.text != "" else {
//            _alert(view: self, message: "请先填写完信息")
//            return
//        }
//        _dismiss(view: self)
        self.usernameTxt.resignFirstResponder()
        self.passwordTxt.resignFirstResponder()
        self.loginSuccess(message: "Login Success")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setTextFieldBottomLine(textFiled: self.usernameTxt)
//        setTextFieldBottomLine(textFiled: self.passwordTxt)
    }
    
    func loginSuccess(message: String) {
//        _alert(view: self, message: message)
//        _login()
//        self.navigationController?.popToViewController(MemberViewController(), animated: true)
//        self.navigationController?.popToRootViewController(animated: true)
//        _open(view: self, vc: HomeViewController())
//        _dismiss(view: self)
//        _open(view: self, vcName: "home", withNav: true)
//        self.view.window?.rootViewController = HomeViewController()
        
        let vc = HomeViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
        _push(view: self, target: vc)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField){
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        })
    }
    
    //输入框返回时操作
    func textFieldShouldReturn(_ textField:UITextField) -> Bool{
        let tag = textField.tag
        switch tag {
        case 100:
            self.passwordTxt.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text!)
        }
        textField.resignFirstResponder()
        return true
    }
    
    //登录按钮点击
    func loginConfrim(){
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

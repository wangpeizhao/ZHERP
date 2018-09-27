//
//  RegisteringViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/28.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class RegisteringViewController: UIViewController, UITextFieldDelegate {
    
    var formView: UIView! //
    var titleLabel: UILabel! //
    var usernameTxt: UITextField!
    var usernameTip: UILabel!
    var passwordTxt: UITextField!
    var passwordTip: UILabel!
    var repasswordTxt: UITextField!
    var repasswordTip: UILabel!
    
    var registerBtn: UIButton!
    var loginBtn: UIButton!
    
    var hasAccount: UILabel!
    
    var topConstraint: Constraint? //Form框距顶部距离约束
    
    var CV: CGFloat = 40 // Common Value
    
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //视图背景色
//        self.view.backgroundColor = Specs.color.main
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
        self.titleLabel.text = "纵横ERP - 注册"
        self.titleLabel.textColor = Specs.color.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(multiplayer.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        
        // Form
        let formViewHeight = 300
        self.formView = UIView()
        self.formView.layer.borderWidth = 0
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.CV/2)
            make.right.equalTo(self.CV/2 * -1)
            make.height.equalTo(formViewHeight)
            self.topConstraint = make.centerY.equalTo(self.view).offset(-40).constraint
        }
        
        // User Icon
        let usernameIcon = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        usernameIcon.image = UIImage(named: "iconfont-user")
        
        // Password Icon
        let passwordIcon = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        passwordIcon.image = UIImage(named: "iconfont-password")
        
        // RePassword Icon
        let repasswordIcon = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        repasswordIcon.image = UIImage(named: "iconfont-password")
        
        // Username Field
        self.usernameTxt = UITextField()
//        self.usernameTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.usernameTxt)
        setTextFieldPlaceholser(textFiled: self.usernameTxt, placeholder: "请输入手机号码")
        //输入框左侧图标
        self.usernameTxt.leftView?.addSubview(usernameIcon)
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
        
        // Username Tip
        self.usernameTip = UILabel()
        self.usernameTip.text = "usernameTip"
        self.usernameTip.textColor = Specs.color.red
        self.usernameTip.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.view.addSubview(self.usernameTip)
        self.usernameTip.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.usernameTxt.snp.left).offset(44)
            make.top.equalTo(self.usernameTxt.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // Password Field
        self.passwordTxt = UITextField()
//        self.passwordTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.passwordTxt)
        setTextFieldPlaceholser(textFiled: self.passwordTxt, placeholder: "请输入密码(6~16位数字+字母)")
        //输入框左侧图标
        self.passwordTxt.leftView?.addSubview(passwordIcon)
        self.formView.addSubview(self.passwordTxt)
        self.passwordTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.usernameTip.snp.bottom).offset(0)
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
        
        // Password Tip
        self.passwordTip = UILabel()
        self.passwordTip.text = "passwordTip"
        self.passwordTip.textColor = Specs.color.red
        self.passwordTip.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.view.addSubview(self.passwordTip)
        self.passwordTip.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.passwordTxt.snp.left).offset(44)
            make.top.equalTo(self.passwordTxt.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // RePassword Field
        self.repasswordTxt = UITextField()
//        self.repasswordTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.repasswordTxt)
        setTextFieldPlaceholser(textFiled: self.repasswordTxt, placeholder: "请输入密码(6~16位数字+字母)")
        //输入框左侧图标
        self.repasswordTxt.leftView?.addSubview(repasswordIcon)
        self.formView.addSubview(self.repasswordTxt)
        self.repasswordTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.passwordTip.snp.bottom).offset(0)
        }
        
        // Separator
        let SeparatorRP = UILabel()
        SeparatorRP.backgroundColor = Specs.color.white
        self.formView.addSubview(SeparatorRP)
        SeparatorRP.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self.repasswordTxt)
            make.left.equalTo(self.repasswordTxt.snp.left)
            make.height.equalTo(0.5)
            make.top.equalTo(self.repasswordTxt.snp.bottom)
        }
        
        // RePassword Tip
        self.repasswordTip = UILabel()
        self.repasswordTip.text = "repasswordTip"
        self.repasswordTip.textColor = Specs.color.red
        self.repasswordTip.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.view.addSubview(self.repasswordTip)
        self.repasswordTip.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.repasswordTxt.snp.left).offset(44)
            make.top.equalTo(self.repasswordTxt.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // Register Button
        self.registerBtn = UIButton()
        setButtonCommon(button: self.registerBtn, title: "注册", isEnabled: false)
        self.registerBtn.addTarget(self, action: #selector(registerBtnClicked), for: .touchUpInside)
        self.formView.addSubview(self.registerBtn)
        self.registerBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(self.repasswordTip.snp.bottom).offset(10)
            make.height.equalTo(self.CV)
        }
        
        // Login Button
        self.loginBtn = UIButton()
        self.loginBtn.setTitle("登录", for: UIControlState())
        self.loginBtn.setTitleColor(Specs.color.main, for: UIControlState())
        self.loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.loginBtn.addTarget(self, action: #selector(LoginBtn(_:)), for: .touchUpInside)
        self.formView.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.registerBtn)
            make.top.equalTo(self.registerBtn.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        // Have account
        self.hasAccount = UILabel()
        self.hasAccount.text = "已有账号？"
        self.hasAccount.textColor = Specs.color.white
        self.hasAccount.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.formView.addSubview(self.hasAccount)
        self.hasAccount.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.loginBtn.snp.left).offset(-5)
            make.top.equalTo(self.loginBtn)
            make.height.equalTo(self.loginBtn)
        }
        
//        setTextFieldBottomLine(textFiled: self.usernameTxt)
//        setTextFieldBottomLine(textFiled: self.passwordTxt)
//        setTextFieldBottomLine(textFiled: self.repasswordTxt)
        
        
        let registerVM = RegisterVM()
        
        usernameTxt.rx.text.orEmpty
            .bind(to: registerVM.username)
            .disposed(by: disposeBag)
        
        passwordTxt.rx.text.orEmpty
            .bind(to: registerVM.password)
            .disposed(by: disposeBag)
        
        repasswordTxt.rx.text.orEmpty
            .bind(to: registerVM.repassword)
            .disposed(by: disposeBag)
        
        registerBtn.rx.tap
            .bind(to: registerVM.registerTaps)
            .disposed(by: disposeBag)
        
        
        registerVM.usernameUseable
            .bind(to: usernameTip.rx.validationResult)
            .disposed(by: disposeBag)
        
        registerVM.usernameUseable
            .bind(to: passwordTxt.rx.inputEnabled)
            .disposed(by: disposeBag)
        
        registerVM.passwordUseable
            .bind(to: passwordTip.rx.validationResult)
            .disposed(by: disposeBag)
        
        registerVM.passwordUseable
            .bind(to: repasswordTxt.rx.inputEnabled)
            .disposed(by: disposeBag)
        
        registerVM.repasswordUseable
            .bind(to: repasswordTip.rx.validationResult)
            .disposed(by: disposeBag)
        
        registerVM.registerButtonEnabled
            .subscribe(onNext: { [unowned self] valid in
                self.registerBtn.isEnabled = valid
                self.registerBtn.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        registerVM.registerResult
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case let .ok(message):
                    self.loginSuccess(message: message)
                case .empty:
                    _alert(view: self, message: "")
                case let .failed(message):
                    _alert(view: self, message: message)
                }
            })
            .disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func registerBtnClicked(_ sender: Any) {
        guard usernameTxt.text != nil && passwordTxt.text != nil && repasswordTxt.text != nil else {
            _alert(view: self, message: "请先填写完信息")
            return
        }
    }
    @objc func LoginBtn(_ sender: Any) {
        _open(view: self, vcName: "login", withNav: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setTextFieldBottomLine(textFiled: self.usernameTxt)
//        setTextFieldBottomLine(textFiled: self.passwordTxt)
//        setTextFieldBottomLine(textFiled: self.repasswordTxt)
    }
    
    func loginSuccess(message: String) {
        _alert(view: self, message: message)
        _login()
//        self.navigationController?.popToViewController(MemberViewController(), animated: true)
        self.navigationController?.popToRootViewController(animated: true)
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
            registerConfrim()
        default:
            print(textField.text!)
        }
        return true
    }
    
    //注册按钮点击
    func registerConfrim(){
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

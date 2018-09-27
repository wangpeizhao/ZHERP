//
//  ForgetViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/28.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ForgetViewController: UIViewController, UITextFieldDelegate {
    
    var formView: UIView! //
    var titleLabel: UILabel! //
    var usernameTxt: UITextField!
    var securityCodeTxt: UITextField!
    
    var nextBtn: UIButton!
    var loginBtn: UIButton!
    var sendBtn: UIButton!
    
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
        self.titleLabel.text = "纵横ERP - 找回密码"
        self.titleLabel.textColor = Specs.color.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(multiplayer.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        
        // Form
        let formViewHeight = 200
        self.formView = UIView()
        self.formView.layer.borderWidth = 0
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.CV/2)
            make.right.equalTo(self.CV/2 * -1)
            make.height.equalTo(formViewHeight)
            self.topConstraint = make.centerY.equalTo(self.view).offset(-50).constraint
        }

        // Username Field
        self.usernameTxt = UITextField()
//        self.usernameTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.usernameTxt, width: 0, height: 0)
        setTextFieldPlaceholser(textFiled: self.usernameTxt, placeholder: "请输入手机号码")
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
        
        // securityCode Field
        self.securityCodeTxt = UITextField()
//        self.securityCodeTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.securityCodeTxt, width: 0, height: 0)
        setTextFieldPlaceholser(textFiled: self.securityCodeTxt, placeholder: "请输入手机验证码")
        self.securityCodeTxt.keyboardType = UIKeyboardType.numberPad
        self.formView.addSubview(self.securityCodeTxt)
        self.securityCodeTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
//            make.right.equalTo(self.sendBtn.snp.left).offset(-10)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.usernameTxt.snp.bottom).offset(20)
            make.width.equalTo(ScreenWidth - self.CV - 100 - 20)
        }
        // Separator
        let SeparatorC = UILabel()
        SeparatorC.backgroundColor = Specs.color.white
        self.formView.addSubview(SeparatorC)
        SeparatorC.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(self.securityCodeTxt)
            make.left.equalTo(self.securityCodeTxt.snp.left)
            make.height.equalTo(0.5)
            make.top.equalTo(self.securityCodeTxt.snp.bottom)
        }
        
        // Send Button
        self.sendBtn = UIButton()
        self.sendBtn.setTitle("获取验证码", for: UIControlState())
        self.sendBtn.setTitleColor(Specs.color.white, for: UIControlState())
        self.sendBtn.layer.cornerRadius = Specs.border.radius
        self.sendBtn.layer.masksToBounds = true
        self.sendBtn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.large)
        self.sendBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        self.sendBtn.isEnabled = false
        self.formView.addSubview(self.sendBtn)
        self.sendBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.width.equalTo(100)
            make.bottom.equalTo(SeparatorC.snp.bottom)
        }
        
        // Next Button
        self.nextBtn = UIButton()
        self.nextBtn.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        setButtonCommon(button: self.nextBtn, title: "下一步", isEnabled: true)
        self.nextBtn.addTarget(self, action: #selector(nextBtnClicked(_:)), for: .touchUpInside)
        self.formView.addSubview(self.nextBtn)
        self.nextBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(self.securityCodeTxt.snp.bottom).offset(30)
            make.height.equalTo(self.CV)
        }
        
        // Login Button
        self.loginBtn = UIButton()
        self.loginBtn.setTitle("快速登录", for: UIControlState())
        self.loginBtn.setTitleColor(Specs.color.white, for: UIControlState())
        self.loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.loginBtn.addTarget(self, action: #selector(loginBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.formView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.centerX.equalTo(self.view)
        }
        
//        setTextFieldBottomLine(textFiled: self.usernameTxt)
//        setTextFieldBottomLine(textFiled: self.securityCodeTxt)
        
        
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
    
    @objc func loginBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "login", withNav: false)
    }
    @objc func nextBtnClicked(_ sender: Any) {
        guard usernameTxt.text != nil && securityCodeTxt.text != nil else {
            _alert(view: self, message: "请先填写完信息")
            return
        }
        _open(view: self, vc: ResetViewController(), withNav: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setTextFieldBottomLine(textFiled: self.usernameTxt)
//        setTextFieldBottomLine(textFiled: self.securityCodeTxt)
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
            self.securityCodeTxt.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text!)
        }
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

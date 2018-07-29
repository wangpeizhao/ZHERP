//
//  ResetViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/28.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ResetViewController: UIViewController, UITextFieldDelegate {
    
    var formView: UIView! //
    var titleLabel: UILabel!
    var passwordTxt: UITextField!
    var repasswordTxt: UITextField!
    
    var resetBtn: UIButton!
    var backBtn: UIButton!
    
    var topConstraint: Constraint? //Form框距顶部距离约束
    
    var CV: CGFloat = 40 // Common Value
    
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //视图背景色
        self.view.backgroundColor = Specs.color.main
        
        //标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = "纵横ERP - 重置密码"
        self.titleLabel.textColor = Specs.color.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(84)
            make.left.equalTo(self.CV/2)
            make.height.equalTo(self.CV)
        }
        
        // Form
        let formViewHeight = 200
        self.formView = UIView()
        self.formView.layer.borderWidth = 0
//        self.formView.layer.backgroundColor = UIColor.gray.cgColor
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.CV/2)
            make.right.equalTo(self.CV/2 * -1)
            make.height.equalTo(formViewHeight)
            self.topConstraint = make.centerY.equalTo(self.view).offset(-30).constraint
        }
        
        // Password Field
        self.passwordTxt = UITextField()
        self.passwordTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.passwordTxt, width: 0, height: 0)
        setTextFieldPlaceholser(textFiled: self.passwordTxt, placeholder: "请输入密码(6~16位数字+字母)")
        self.formView.addSubview(self.passwordTxt)
        self.passwordTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.formView.snp.top).offset(5)
        }
        
        // RePassword Field
        self.repasswordTxt = UITextField()
        self.repasswordTxt.delegate = self
        setTextFieldCommonFeatures(textFiled: self.repasswordTxt, width: 0, height: 0)
        setTextFieldPlaceholser(textFiled: self.repasswordTxt, placeholder: "请重复输入密码")
        self.formView.addSubview(self.repasswordTxt)
        self.repasswordTxt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.CV)
            make.top.equalTo(self.passwordTxt.snp.bottom).offset(10)
        }
        
        // Reset Button
        self.resetBtn = UIButton()
        setButtonCommon(button: self.resetBtn, title: "重置", isEnabled: true)
        self.resetBtn.addTarget(self, action: #selector(resetBtnClicked(_:)), for: .touchUpInside)
        self.formView.addSubview(self.resetBtn)
        self.resetBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(self.repasswordTxt.snp.bottom).offset(20)
            make.height.equalTo(self.CV)
        }
        
        // Login Button
        self.backBtn = UIButton()
        self.backBtn.setTitle("上一步", for: UIControlState())
        self.backBtn.setTitleColor(Specs.color.white, for: UIControlState())
        self.backBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.backBtn.addTarget(self, action: #selector(goBackBtn(_:)), for: .touchUpInside)
        self.view.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.formView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.centerX.equalTo(self.view)
        }
        
//
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
//        repasswordTxt.rx.text.orEmpty
//            .bind(to: registerVM.repassword)
//            .disposed(by: disposeBag)
//
//        registerBtn.rx.tap
//            .bind(to: registerVM.registerTaps)
//            .disposed(by: disposeBag)
//
//
//        registerVM.usernameUseable
//            .bind(to: usernameTip.rx.validationResult)
//            .disposed(by: disposeBag)
//
//        registerVM.usernameUseable
//            .bind(to: passwordTxt.rx.inputEnabled)
//            .disposed(by: disposeBag)
//
//        registerVM.passwordUseable
//            .bind(to: passwordTip.rx.validationResult)
//            .disposed(by: disposeBag)
//
//        registerVM.passwordUseable
//            .bind(to: repasswordTxt.rx.inputEnabled)
//            .disposed(by: disposeBag)
//
//        registerVM.repasswordUseable
//            .bind(to: repasswordTip.rx.validationResult)
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
//
        // Do any additional setup after loading the view.
        
    }
    
    @objc func resetBtnClicked(_ sender: Any) {
        guard passwordTxt.text != nil && repasswordTxt.text != nil else {
            _alert(view: self, message: "请先填写完信息")
            return
        }
        _open(view: self, vcName: "login", withNav: false)
    }
    @objc func goBackBtn(_ sender: Any) {
        print("goBackBtn")
//        _dismiss(view: self)
        _open(view: self, vcName: "forget", withNav: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTextFieldBottomLine(textFiled: self.passwordTxt)
        setTextFieldBottomLine(textFiled: self.repasswordTxt)
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

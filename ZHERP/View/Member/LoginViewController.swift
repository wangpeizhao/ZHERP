//
//  LoginViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/18.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBAction func LoginBtnClicked(_ sender: Any) {
        _login()
        let vc = MemberViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)

    }
    @IBAction func ForgetPwdBtn(_ sender: Any) {
        _open(view: self, vcName: "forget", withNav: true)
//        self.navigationController?.pushViewController(ForgotPwdViewController(), animated: true)
    }
    @IBAction func RegisterBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "register", withNav: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setBackBtn(view: self, selector: selector, title: "", parent: false)
        
        LoginBtn.layer.cornerRadius = Specs.border.radius
        setUITextFieldBP(textFiled: usernameTxt, placeholder: "请输入手机号码")
        setUITextFieldBP(textFiled: passwordTxt, placeholder: "请输入密码(6~16位数字+字母)")
    }
    
    @objc func actionBack() {
        _dismiss(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("LoginViewController")
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

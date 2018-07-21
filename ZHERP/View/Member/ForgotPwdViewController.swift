//
//  LoggingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/18.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class ForgotPwdViewController: UIViewController {
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var verificationCodeTxt: UITextField!
    @IBOutlet weak var verificationCodeBtn: UIButton!
    @IBOutlet weak var ForgetPwdBtn: UIButton!
    @IBAction func verificationCodeBtnClicked(_ sender: Any) {
    }
    @IBAction func ForgetPwdBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "resetPwd", withNav: true)
    }
    @IBAction func LoginBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "login", withNav: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set bar
        setNavBarTitle(view: self, title: "", transparent: true)
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setBackBtn(view: self, selector: selector, title: "", parent: true)
        
        // Do any additional setup after loading the view.
        
        ForgetPwdBtn.layer.cornerRadius = Specs.border.radius
        verificationCodeBtn.layer.cornerRadius = Specs.border.radius
        setUITextFileBP(textFiled: usernameTxt, placeholder: "请输入手机号码")
        setUITextFileBP(textFiled: verificationCodeTxt, placeholder: "请输入手机验证码")
    }
    
    @objc func actionBack() {
        _dismiss(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.title = "Logging"
//        let leftBtn:UIBarButtonItem=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: "actionBack")
//
//        leftBtn.title="返回";
//
//        leftBtn.tintColor=UIColor.white;
//        //        self.navigationItem
//        self.navigationItem.leftBarButtonItem=leftBtn;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  LoginViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/18.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class ResetPwdViewController: UIViewController {
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repasswordTxt: UITextField!
    @IBOutlet weak var ResetPwdBtn: UIButton!
    @IBAction func RestPwdBtnClicked(_ sender: Any) {
        _open(view: self, vcName: "login", withNav: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set bar
        setNavBarTitle(view: self, title: "", transparent: true)
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setBackBtn(view: self, selector: selector, title: "Back", parent: false)
        
        // Do any additional setup after loading the view.
        
        ResetPwdBtn.layer.cornerRadius = Specs.border.radius
        setUITextFileBP(textFiled: passwordTxt, placeholder: "请输入新密码")
        setUITextFileBP(textFiled: repasswordTxt, placeholder: "请重复输入密码")
    }
    
    @objc func actionBack() {
        _dismiss(view: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

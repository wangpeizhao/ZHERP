//
//  LoginViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/18.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBAction func ProtocilDetailBtn(_ sender: Any) {
        // 协议
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProtocolPageViewController") as! ProtocolPageViewController
        _open(view: self, vc: vc)
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        _login()
        let vc = MemberViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    @IBAction func registerBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        _open(view: self, vc: vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle(view: self, title: "登录")
        let selector: Selector = #selector(actionBack)
        setBackBtn(view: self, selector: selector)
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

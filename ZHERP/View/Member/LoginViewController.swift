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
        
        // 黑屏
        //        let vc = LoginViewController()
        //        self.present(vc, animated: true, completion: nil)
        
        // 正常
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "ProtocolPageViewController") as! ProtocolPageViewController
                self.present(vc, animated: true, completion: nil)
        //        self.showDetailViewController(vc, sender: vc)
//        self.show(vc, sender: ProtocolPageViewController.self)
        
        // 正常
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //        self.present(vc, animated: true, completion: nil)
        
        // 没反应
        //        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        
        // 黑屏
        //        self.present(LoginViewController(), animated: true, completion: nil)
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        let vc = MemberViewController()
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Haha"
        let leftBtn:UIBarButtonItem=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(_action))
        
        leftBtn.title="返回";
        
        leftBtn.tintColor=UIColor.white;
        //        self.navigationItem
        self.navigationItem.leftBarButtonItem=leftBtn;
        // Do any additional setup after loading the view.
//        UIButton
        // Do any additional setup after loading the view.
    }
    
    @objc func _action() {
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.dismiss(animated: true, completion: nil)
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

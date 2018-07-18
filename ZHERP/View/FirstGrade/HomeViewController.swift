//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBAction func MemberCenter(_ sender: Any) {
        // 黑屏
//        let vc = LoginViewController()
//        self.present(vc, animated: true, completion: nil)
        
        // 正常
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
//        self.showDetailViewController(vc, sender: vc)
//        self.show(nav, sender: LoginViewController.self)
        
        // 正常
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.present(vc, animated: true, completion: nil)

        // 没反应
//        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        
        // 黑屏
//        self.present(LoginViewController(), animated: true, completion: nil)
    }
    @IBOutlet weak var homeTxt: UIButton!
    
    @IBAction func MemberInfo(_ sender: Any) {
        
        print("Go to MemberViewController")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
//        self.present(vc, animated: true, completion: nil)
        
        //
        let vc = MemberViewController()
        self.present(vc, animated: true, completion: nil)
//        self.show(vc as UIViewController, sender: vc)
        
        //
//        let sb = UIStoryboard(name: "Main", bundle:nil)
//        let vc = sb.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
//        self.present(vc, animated: true, completion: nil)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
        
        //先隐藏回退按钮，然后push 否则无效
        
//        vc.navigationItem.hidesBackButton=true
        
//        self.navigationController?.pushViewController(vc , animated:true)
        
//        self.present(LoginViewController(), animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "纵横ERP"
        
//        self.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//        self.navigationItem.leftItemsSupplementBackButton = true
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Facebook"
        navigationController?.navigationBar.barTintColor = Specs.color.tint
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

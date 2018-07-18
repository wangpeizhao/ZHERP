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
        // open view
        let vc: UIViewController?
        if(checkLogin()) {
            vc = self.storyboard?.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
        } else {
            vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        }
        _open(view: self, vc: vc!)
    }
    
    @IBOutlet weak var homeTxt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "纵横ERP"
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

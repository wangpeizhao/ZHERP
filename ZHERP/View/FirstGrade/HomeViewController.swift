//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var vc: UIViewController!
    var withNav: Bool!
    
    @IBAction func MemberCenter(_ sender: Any) {
        _open(view: self, vcName: "member")
    }
    
    @IBOutlet weak var homeTxt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavBarTitle(view: self, title: "纵横ERP")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if(checkLoginStatus()) {
//            _open(view: self, vcName: "home")
//        } else {
//            _open(view: self, vcName: "login", withNav: false)
//        }
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

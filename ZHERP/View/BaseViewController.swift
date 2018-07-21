//
//  BaseViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/21.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if(checkLoginStatus()) {
//            _open(view: self, vcName: "home")
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        checkLogin(view: self)
    }
}

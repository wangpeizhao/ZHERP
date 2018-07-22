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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(checkLoginStatus()) {
            // _open(view: self, vcName: "home")
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
}

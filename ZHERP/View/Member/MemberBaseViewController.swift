//
//  MemberBaseViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class MemberBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Specs.color.gray
//        checkLogin(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin(view: self)
    }
}

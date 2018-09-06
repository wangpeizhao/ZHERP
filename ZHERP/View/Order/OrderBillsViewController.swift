//
//  OrderBillsViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderBillsViewController: UIViewController {

    var pageMenuView: UIView!
    var orderPageMenuView: OrderBillsPagesViewController?
    var navHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        
        setNavBarTitle(view: self, title: "账单")
        setNavBarBackBtn(view: self, title: "历史账单", selector: #selector(actionBack))
        setNavBarRightBtn(view: self, title: "更多", selector: #selector(actionMore))
        
        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionMore() {
        
    }
    
    private func _setUp() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        GlobalNavHeight = self.navHeight
        
        self.pageMenuView = UIView(frame: CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(self.pageMenuView)
        
        self.orderPageMenuView = OrderBillsPagesViewController()
        self.addChildViewController(self.orderPageMenuView!)
        self.pageMenuView.addSubview((self.orderPageMenuView?.view)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  HAllocatingView.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/9.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HAllocatingView: UIViewController {

    // 购物车数量
    var _cartqQuantity: UILabel!
    // 合计总价
    var _totalValue: UILabel!
    
    var _submitAdd: UIButton!
    
    var tabBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

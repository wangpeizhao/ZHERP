//
//  OrderDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var OrderPrice: UILabel!
    @IBOutlet weak var OrderTitle: UILabel!
    
    var detailCandy: Candy? {
        didSet {
        }
    }
    
    var navTitle: String?
    var order_title: String?
    var order_price: String?
    var order_image: String?
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        self.OrderPrice.text = order_price!
        self.OrderTitle.text = order_title!
        self.orderImage.image = UIImage(named: order_image!)
        
//        let selector: Selector = #selector(actionBack)
//        setNavBarLeftBtn(view: self, title: "Order", selector: selector)
        setNavBarTitle(view: self, title: navTitle!)
    }
    
    @objc func actionBack() {
        print("close")
        _close(view: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

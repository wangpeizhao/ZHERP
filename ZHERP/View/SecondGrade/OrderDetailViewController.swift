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
    var actionValue: String?
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarLeftBtn(view: self, title: "关闭", selector: #selector(actionClose))
        if (actionValue?.isEmpty)! {
            actionValue = "1234567890"
        }
        self.OrderPrice.text = order_price!
        self.OrderTitle.text = order_title! + "id = " + actionValue!
        self.orderImage.image = UIImage(named: order_image!)
        
//        let selector: Selector = #selector(actionBack)
//        setNavBarLeftBtn(view: self, title: "Order", selector: selector)
        setNavBarTitle(view: self, title: navTitle!)
    }
    
    @objc func actionClose() {
        print("close")
//        _close(view: self)
//        self.navigationController?.popToRootViewController(animated: true)
//        self.navigationController?.popToViewController(GoodViewController() , animated: true)
        _back(view: self, root: true)
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

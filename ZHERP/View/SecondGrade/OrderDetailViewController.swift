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
        order_price = "order_price"
        order_title = "order_title"
        order_image = "bayMax"
        print(order_price!)
        print(order_title!)

        print(self.OrderPrice)
//        self.OrderPrice.text = order_price!
//        self.OrderTitle.text = order_title!
//        self.orderImage.image = UIImage(named: order_image!)
        
        setNavBarTitle(view: self, title: navTitle!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

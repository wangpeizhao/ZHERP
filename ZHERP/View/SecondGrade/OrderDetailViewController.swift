//
//  OrderDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {

    @IBOutlet weak var OrderPrice: UILabel!
    @IBOutlet weak var OrderTitle: UILabel!
    var detailCandy: Candy? {
        didSet {
//            configureView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(detailCandy?.name)
        OrderTitle.text = detailCandy?.name
        OrderPrice.text = detailCandy?.category
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

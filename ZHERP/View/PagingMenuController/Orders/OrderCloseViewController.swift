//
//  OrderCloseViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderCloseViewController: UIViewController {
    
    var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        self.contentLabel.text = "Close"
        self.view.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        
        // Do any additional setup after loading the view.
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

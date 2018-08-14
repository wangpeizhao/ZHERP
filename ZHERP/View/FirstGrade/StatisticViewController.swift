//
//  StatisticViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import AVFoundation

class StatisticViewController: UIViewController {
    
//    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    @IBAction func openCamera(_ sender: Any) {
        _push(view: self, target: CameraViewController())
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(CameraViewController(), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        searchBar.placeholder = "搜索"
//        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
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

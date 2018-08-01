//
//  SearchViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/1.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "订单", selector: selector)
        
        // set bar
        setNavBarTitle(view: self, title: "订单类型", transparent: true)

        // Do any additional setup after loading the view.
        
        searchBar.placeholder = "搜索"
        searchBar.backgroundColor = Specs.color.grayBg
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    @objc func actionBack() {
        self.hidesBottomBarWhenPushed = false
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

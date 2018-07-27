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
//    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchBar: UISearchBar!
    
//    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(detailCandy?.name)
        OrderTitle.text = detailCandy?.name
        OrderPrice.text = detailCandy?.category
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Facebook"
        navigationController?.navigationBar.barTintColor = Specs.color.tint
        
//        searchBar.placeholder = "搜索"
        searchBar.backgroundColor = Specs.color.gray
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        
        
//        searchController.searchBar.searchBarStyle = .Minimal//搜索框风格
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

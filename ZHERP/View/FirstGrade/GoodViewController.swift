//
//  GoodViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class GoodViewController: UIViewController {
    //搜索控制器
    var countrySearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self   //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
//            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        self.view.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
        self.view.backgroundColor = UIColor.gray
self.view.addSubview(countrySearchController.searchBar)
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
extension GoodViewController: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
//        self.searchArray = self.schoolArray.filter { (school) -> Bool in
//            return school.contains(searchController.searchBar.text!)
//        }
        print("dfdfdfdfdfdfdfd..........")
    }
}

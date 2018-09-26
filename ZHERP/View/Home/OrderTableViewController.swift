//
//  OrderTableViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    // MARK: 搜索控制器
    var searchController: ZHSearchController?
    
    // 当前IOS系统版本
    var currentVersion: Int!
    var candies:[Candy] = []
    let identifier: String = "OrderIdentifier"
    var orderDetailViewController: OrderDetailViewController? = nil
    
    @IBOutlet var   searchBar: UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 搜索控制器
        let searchController = ZHSearchController(searchResultsController: UITableViewController())
        self.searchController = searchController
        
        
        
        
        tableView.tableHeaderView = searchController.searchBar
        
        
        
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "订单", selector: selector)
        
        // set bar
        setNavBarTitle(view: self, title: "订单类型", transparent: true)
        
        
//        buildSearchBar(searchBar: searchController.searchBar, placeholder: "按订单号搜索")
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = true
//        searchController.searchBar.searchBarStyle = .minimal
//        searchController.searchBar.sizeToFit()
//        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        searchController.searchBar.backgroundColor = Specs.color.white
        
//        searchController.searchBar.layer.masksToBounds = true;
//        searchController.searchBar.layer.cornerRadius = 2;
//        searchController.searchBar.layer.borderWidth = 0;
//        searchController.searchBar.contentMode = .center;
//        // searchBar弹出的键盘类型设置
//        searchController.searchBar.returnKeyType = UIReturnKeyType.search;
//        searchController.searchBar.placeholder = "搜索订单号"
//        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
//
//        searchController.searchBar.setPositionAdjustment(UIOffsetMake((searchController.searchBar.frame.size.width - 20 - 80 ) / 2 , 0), for: UISearchBarIcon.search)
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        // 获取系统版本号
        currentVersion = getIOSVersion()
        
        // 使键盘点击空白处关闭
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped(tap:)));
//        tap.cancelsTouchesInView = false;
//        self.view.addGestureRecognizer(tap);
        
//        searchBar.backgroundColor = Specs.color.graySBg
//        searchBar.backgroundColor = UIColor.yellow
        
        searchBar.barStyle = UIBarStyle.default
        searchBar.barTintColor = UIColor.clear
        
        searchBar.placeholder = "searchbar的使用"
        searchBar.tintColor = UIColor.red
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        
//        let uiButton = searchBar.value(forKey: "cancelButton") as! UIButton
//        uiButton.setTitle("搜索", for: .normal)
//        uiButton.setTitleColor(UIColor.orange,for: .normal)
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        candies = [
            Candy(category: "Chocolate", name: "Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark Chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy Cane"),
            Candy(category:"Hard", name:"Jaw Breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour Chew"),
            Candy(category:"Other", name:"Gummi Bear")
        ]
        
        setupSearchController()
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            orderDetailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? OrderDetailViewController
        }
        
        UISearchBar.appearance().barTintColor = UIColor.candyGreen()
        UISearchBar.appearance().tintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.candyGreen()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func viewTapped(tap: UITapGestureRecognizer) {
//        searchController.resignFirstResponder()
    }
    
    @objc func actionBack() {
        self.hidesBottomBarWhenPushed = false
    }
    
    func setupSearchController() {
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
//        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
//        searchController.searchBar.delegate = self
    }
    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredCandies = candies.filter { candy in
//            if !(candy.category == scope) && scope != "All" {
//                print("return false: " + scope)
//                return false
//            }
//            print("return true: " + scope)
//            return candy.name.lowercased().contains(searchText.lowercased()) || searchText == ""
//        }
//        tableView.reloadData()
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
////        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
//        super.viewWillAppear(animated)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if searchController.isActive {
//            return filteredCandies.count
//        }
        return candies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let candy: Candy
//        if searchController.isActive {
//            candy = filteredCandies[(indexPath as NSIndexPath).row]
//        } else {
            candy = candies[(indexPath as NSIndexPath).row]
//        }

        cell.textLabel!.text = candy.name
//        cell.detailTextLabel!.text = candy.category

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        if segue.identifier == "OrderDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Candy
//                if searchController.isActive {
//                    candy = filteredCandies[(indexPath as NSIndexPath).row]
//                } else {
//                    candy = candies[(indexPath as NSIndexPath).row]
//                }
                self.hidesBottomBarWhenPushed = true
                
                candy = candies[(indexPath as NSIndexPath).row]
                let controller = segue.destination as! OrderDetailViewController
//                controller.detailCandy = candy
                print(candy.category + "===" + candy.name)
//                self.hidesBottomBarWhenPushed = false
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}


extension OrderTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("UISearchResultsUpdating:filterContentForSearchText")
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        
    }
}

//extension OrderTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        print("UISearchBarDelegate:filterContentForSearchText")
////        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
//}

extension OrderTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        输入时需要进行的操作
        print(searchBar.text!)
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
//        if currentVersion >= 11 {
            searchBar.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
//            self.searchController.
//        }
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldEndEditing")
//        if currentVersion >= 11 {
            searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
//        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        //        输入完成时，点击按钮需要进行的操作
        searchBar.resignFirstResponder()
    }
}


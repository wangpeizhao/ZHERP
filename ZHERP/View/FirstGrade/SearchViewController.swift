//
//  SearchViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/1.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var tableArray: NSArray = ["AB_PPC01","BC_PPC02","CD_PPC03","DE_PPC04","EF_PPC05","FG_PPC06","GH_PPC07","HI_PPC08","IJ_PPC09","JK_PPC10"]
    
    var itemArray : [Int: [String:String]] = [
        0: ["imagePath": "bayMax", "suk": "AB_PPC01", "title": "六神花露水001", "price": "17.50"],
        1: ["imagePath": "bayMax", "suk": "BC_PPC02", "title": "六神花露水002", "price": "17.50"],
        2: ["imagePath": "bayMax", "suk": "CD_PPC03", "title": "六神花露水003", "price": "17.50"],
        3: ["imagePath": "bayMax", "suk": "DE_PPC04", "title": "六神花露水004", "price": "17.50"],
        4: ["imagePath": "bayMax", "suk": "EF_PPC05", "title": "六神花露水005", "price": "17.50"],
        5: ["imagePath": "bayMax", "suk": "FG_PPC06", "title": "六神花露水006", "price": "17.50"],
        6: ["imagePath": "bayMax", "suk": "GH_PPC07", "title": "六神花露水007", "price": "17.50"],
        7: ["imagePath": "bayMax", "suk": "HI_PPC08", "title": "六神花露水008", "price": "17.50"],
        8: ["imagePath": "bayMax", "suk": "IJ_PPC09", "title": "六神花露水009", "price": "17.50"],
        9: ["imagePath": "bayMax", "suk": "JK_PPC10", "title": "六神花露水010", "price": "17.50"],
        10: ["imagePath": "bayMax", "suk": "KL_PPC11", "title": "六神花露水011", "price": "17.50"]
    ]
    var tempsArray : [Int: [String:String]] = [:]
    var dataArray : [Int: [String:String]] = [:]
    
    var searchArray: NSArray = []
    var isSearch = false//默认在非搜索状态下
    
    let resultIdentify: String = "resultIdentify"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.tableView.tableHeaderView = self.searchBar;
        self.view.addSubview(self.searchBar);
        self.view.addSubview(tableView);
        
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: resultIdentify)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //使用懒加载方式来创建UITableView
    lazy var tableView: UITableView = {
//        let tempTableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.plain)
        let tempTableView = UITableView (frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tableFooterView = UIView.init()
        tempTableView.backgroundColor = Specs.color.white
        return tempTableView
    }()
    
    //使用懒加载方式来创建UISearchBar
    lazy var searchBar: UISearchBar = {
        let tempSearchBar = UISearchBar(frame:CGRect(x: 0, y: 44, width: self.view.bounds.size.width, height: 30))
        //        tempSearchBar.prompt = "查找图书";
        tempSearchBar.placeholder = "请输入搜索关键字";
        tempSearchBar.showsCancelButton = true;
        tempSearchBar.delegate = self
        tempSearchBar.sizeToFit()
        tempSearchBar.becomeFirstResponder()
        tempSearchBar.backgroundColor = Specs.color.white
        tempSearchBar.barTintColor = Specs.color.white
        tempSearchBar.tintColor = Specs.color.gray
        tempSearchBar.searchBarStyle = .default
        
        let uiButton = tempSearchBar.value(forKey: "cancelButton") as! UIButton
        uiButton.setTitle("取消", for: .normal)
        uiButton.setTitleColor(UIColor.gray,for: .normal)
        return tempSearchBar
    }()
    
    //根据输入的关键字来过滤搜索结果
    func filterBySubstring(filterStr: NSString!) {
        isSearch = true
        let predicate = NSPredicate(format: "SELF CONTAINS[c] %@", filterStr)
        searchArray = tableArray.filtered(using: predicate) as NSArray
        tableView.reloadData()
    }
    
    func searchContentForText(filterStr: String){
        if (filterStr.isEmpty) {
            isSearch = false
            self.dataArray = self.tempsArray
        } else {
            isSearch = true
            self.tempsArray.removeAll()
            var i: Int = 0
            for (_,item) in self.itemArray {
                let suk: String = item["suk"]!
                if suk.contains(filterStr) {
                    self.tempsArray[i] = item
                    i += 1
                }
            }
            print(self.tempsArray)
            self.dataArray = self.tempsArray
        }
        tableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return dataArray.count
        }
        else{
            return tableArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearch {
            let count = self.dataArray.count
            let sectionNo = count - indexPath.row - 1
            let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: resultIdentify) as! OrderTableViewCell
            if !((self.dataArray[sectionNo]?.isEmpty)!) {
                var _data = self.dataArray[sectionNo]!
                
                cell.orderImage.image = UIImage(named: _data["imagePath"]!)
                cell.sukLabel.text = _data["suk"]
                cell.titleLabel.text = _data["title"]
                cell.priceLabel.text = _data["price"]
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }
        
        let identifier = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        
        let row = indexPath.row
        if isSearch {
            cell?.textLabel?.text = searchArray[row] as? String
        }
        else{
            cell?.textLabel?.text = tableArray[row] as? String
        }
        
        return cell!
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearch {
            let sb = UIStoryboard(name:"Main", bundle: nil)
            let orderView = sb.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
            
            orderView.hidesBottomBarWhenPushed = true
            
            let count = self.dataArray.count
            let sectionNo = count - indexPath.row - 1
            var _data = self.dataArray[sectionNo]!
            orderView.navTitle = _data["suk"]
            orderView.order_image = _data["imagePath"]
            orderView.order_price = _data["price"]
            orderView.order_title = _data["title"]
            print("push push push push push push push push push push push push push push push push push push push")
            _push(view: self, target: orderView, rootView: false)
            self.presentingViewController?.navigationController?.pushViewController(orderView, animated: true)
        } else {
//            isSearch = true
            let keyword: String? = tableArray[indexPath.row] as? String
            searchBar.text = keyword
            searchContentForText(filterStr: keyword!)
            tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
        _dismiss(view: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        filterBySubstring(filterStr: searchBar.text! as NSString)
        searchContentForText(filterStr: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterBySubstring(filterStr: searchText as NSString)
        searchContentForText(filterStr: searchBar.text!)
    }
}

//
//  SearchViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/1.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tableArray: NSArray = ["UI",
                               "UIView",
                               "View",
                               "ViewController",
                               "Controller",
                               "UIViewController",
                               "Search",
                               "UISearchBar",
                               "Swift"]
    
    var searchArray: NSArray = []
    var isSearch = false//默认在非搜索状态下
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableHeaderView = self.searchBar;
        self.view.addSubview(tableView);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //使用懒加载方式来创建UITableView
    lazy var tableView: UITableView = {
        let tempTableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tableFooterView = UIView.init()
        
        return tempTableView
    }()
    
    //使用懒加载方式来创建UISearchBar
    lazy var searchBar: UISearchBar = {
        let tempSearchBar = UISearchBar(frame:CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 40))
        //        tempSearchBar.prompt = "查找图书";
        tempSearchBar.placeholder = "请输入搜索关键字";
        tempSearchBar.showsCancelButton = true;
        tempSearchBar.delegate = self
        tempSearchBar.becomeFirstResponder()
        tempSearchBar.backgroundColor = Specs.color.white
        
        return tempSearchBar
    }()
    
    //根据输入的关键字来过滤搜索结果
    func filterBySubstring(filterStr: NSString!) {
        isSearch = true
        let predicate = NSPredicate(format: "SELF CONTAINS[c] %@", filterStr)
        searchArray = tableArray.filtered(using: predicate) as NSArray
        tableView.reloadData()
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchArray.count
        }
        else{
            return tableArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
        _dismiss(view: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterBySubstring(filterStr: searchBar.text! as NSString)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterBySubstring(filterStr: searchText as NSString)
    }
    
}

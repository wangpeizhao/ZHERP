//
//  SearchViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/1.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var navBarTitle: String!
    var searchBarPlaceholder: String!
    var searchType: String!
    var navHeight: CGFloat!
    var searchBarHeight: CGFloat!
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
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: !self.navBarTitle.isEmpty ? self.navBarTitle : "搜索")
        setNavBarBackBtn(view: self, title: !self.navBarTitle.isEmpty ? self.navBarTitle : "搜索", selector: #selector(goback))
        
        self._setup()
    }
    
    private func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.searchBarHeight = 56.0
        
        // 设置右侧按钮
        let rightBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtn.image = UIImage(named: "scan")
        rightBarBtn.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtn]
        
        self.view.addSubview(self.searchBar);
        self.view.addSubview(tableView);
    }
    
    @objc func goback() {
        
    }
    
    @objc func delHistory() {
        
    }
    
    @objc func actionScan() {
        self.hidesBottomBarWhenPushed = true
        let _ZHQRCode = ZHQRCodeViewController()
        _ZHQRCode.actionType = "picking"
        _push(view: self, target: _ZHQRCode, rootView: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //使用懒加载方式来创建UITableView
    lazy var tableView: UITableView = {
        let tempTableView = UITableView(frame: CGRect(x: 0, y: self.navHeight + self.searchBarHeight, width: ScreenWidth, height: ScreenHeight), style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tableFooterView = UIView.init()
        tempTableView.backgroundColor = Specs.color.white
        tempTableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: resultIdentify)
        tempTableView.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        return tempTableView
    }()
    
    //使用懒加载方式来创建UISearchBar
    lazy var searchBar: UISearchBar = {
        print("self.navHeight:\(self.navHeight!)")
        print(self.searchType)
        let tempSearchBar = UISearchBar(frame: CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: self.searchBarHeight))
        tempSearchBar.placeholder = !self.searchBarPlaceholder.isEmpty ? self.searchBarPlaceholder : "请输入搜索关键字";
        tempSearchBar.showsCancelButton = true;
        tempSearchBar.delegate = self
        tempSearchBar.sizeToFit()
        tempSearchBar.becomeFirstResponder()
        tempSearchBar.backgroundColor = Specs.color.white
        tempSearchBar.barTintColor = Specs.color.white
        tempSearchBar.tintColor = Specs.color.gray
        tempSearchBar.searchBarStyle = .prominent
        
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "搜索历史"
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let _view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40.0))
        _view.backgroundColor = UIColor(hex: 0xf2f2f2)
        
        // 搜索历史
        let historyTitle = UILabel()
        historyTitle.text = "搜索历史"
        historyTitle.sizeToFit()
        historyTitle.textColor = Specs.color.gray
        historyTitle.font = Specs.font.smallBold
        _view.addSubview(historyTitle)
        historyTitle.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(20)
            make.top.equalTo(10)
        }
        
        // Delete
        let delBtn = UIButton()
        delBtn.setTitle("删除搜索历史", for: .normal)
        delBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        delBtn.setTitleColor(Specs.color.white, for: .normal)
        delBtn.layer.cornerRadius = 4.0
        delBtn.backgroundColor = Specs.color.main
        delBtn.addTarget(self, action: #selector(delHistory), for: .touchUpInside)
        _view.addSubview(delBtn)
        delBtn.snp.makeConstraints{ (make) -> Void in
            make.right.equalTo(-10)
            make.top.equalTo(historyTitle.snp.top).offset(-5)
            make.width.equalTo(90)
        }
        
        return _view
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
            orderView.actionValue = ""
            _push(view: self, target: orderView, rootView: false)
        } else {
            let keyword: String? = tableArray[indexPath.row] as? String
            searchBar.text = keyword
            searchContentForText(filterStr: keyword!)
            self.tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
        _back(view: self, root: true)
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

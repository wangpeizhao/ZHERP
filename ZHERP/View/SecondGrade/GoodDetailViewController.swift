//
//  GoodDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/18.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class GoodDetailViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
    let cellIdentifer = "myCell"
    var searchController: UISearchController?
    
    var tableView: UITableView?
    var itemArray : Array = [String]()
    var tempsArray : Array = [String]()
    
    func initData(){
        for i in 0 ..< 30 {
            let str = "夜如何其\(i)……………………"
            itemArray.append(str)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        self.navigationItem.title = "Search"
        //        self.searchController = UISearchController(searchResultsController: nil)
        //        self.searchController?.hidesNavigationBarDuringPresentation = true
        //        self.searchController?.searchBar.barStyle = .blackTranslucent
        ////        self.searchController?.searchBar.placeHolder = "Search"
        //
        //        self.view.addSubview((self.searchController?.searchBar)!)
        //        self.setCustomTitle("发现")
        self.definesPresentationContext = true
        self.initData()
        self.initSubView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubView(){
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = UIColor.clear
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifer)
        let aaaView = UIView()
        aaaView.backgroundColor = UIColor.white
        self.tableView?.tableFooterView = aaaView
        self.view.addSubview(self.tableView!)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)
        self.searchController?.searchBar.delegate = self
        
        
        self.searchController?.hidesNavigationBarDuringPresentation = true
        self.searchController?.dimsBackgroundDuringPresentation = false
        self.searchController?.searchBar.searchBarStyle = .prominent
//        [[self.searchBar.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
        self.searchController?.searchBar.heightAnchor.constraint(equalToConstant: 44)
        //        self.searchController?.searchBar.sizeToFit()
        //        self.searchController?.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        //        self.searchController?.searchBar.backgroundColor = UIColor.orange
        
        
        //        self.searchController?.searchBar.delegate = self as? UISearchBarDelegate
        //        self.searchController?.searchResultsUpdater = self as? UISearchResultsUpdating
        //
        //        self.searchController?.definesPresentationContext = true
        
        //        self.searchController?.searchBar.tintColor = RGBA(r: 0.12, g: 0.74, b: 0.13, a: 1.00)
        
        //        self.searchController?.searchBar.layer.masksToBounds = true;
        //        self.searchController?.searchBar.layer.cornerRadius = 2;
        //        self.searchController?.searchBar.layer.borderWidth = 0;
        //        self.searchController?.searchBar.contentMode = .center;
        // searchBar弹出的键盘类型设置
        //        self.searchController?.searchBar.returnKeyType = UIReturnKeyType.search;
        //        self.searchController?.searchBar.placeholder = "Search Num"
        self.searchController?.searchBar.barTintColor = UIColor.orange
        //搜索栏取消按钮文字
        //        self.searchController?.searchBar.setValue("取消", forKey:"_cancelButtonText")
       self.searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: (self.searchController?.searchBar.frame.size.width)!, height: 44)
        
        
        self.tableView?.tableHeaderView = self.searchController?.searchBar
    }
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifer, for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    private func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        //do somthing...
    }
    
    
    //mark - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //
        //        let nav_VC = self.searchController?.searchResultsController as! UINavigationController
        //        let resultVC = nav_VC.topViewController as! McSearchResultVC
        //        self.searchContentForText(searchText: (self.searchController?.searchBar.text)!)
        //        resultVC.itemArray = self.tempsArray
        //        resultVC.tableView?.reloadData()
    }
    
    func searchContentForText(searchText: String){
        self.tempsArray.removeAll()
        for str in self.itemArray {
            //
            if str.contains(searchText) {
                self.tempsArray.append(str)
            }
        }
    }
    
    
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        var frame = self.searchController?.searchBar.frame
        frame?.size.height = 31
        self.searchController?.searchBar.frame = frame!
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        // 去除边黑边
        self.searchController?.searchBar.layer.borderColor = UIColor.white.cgColor
        self.searchController?.searchBar.layer.borderWidth = 1
        self.searchController?.searchBar.layer.masksToBounds = true
        
        var frame = self.searchController?.searchBar.frame
        frame?.size.height = 31
        self.searchController?.searchBar.frame = frame!
    }
    
    
    
}


//

class IDSearchBar: UISearchBar {
    var contentInset: UIEdgeInsets? {
        didSet {
            self.layoutSubviews()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // view是searchBar中的唯一的直接子控件
        for view in self.subviews {
            // UISearchBarBackground与UISearchBarTextField是searchBar的简介子控件
            for subview in view.subviews {
                
                // 找到UISearchBarTextField
                
                if subview.isKind(of: UITextField.classForCoder()) {
                    
                    if let textFieldContentInset = contentInset { // 若contentInset被赋值
                        // 根据contentInset改变UISearchBarTextField的布局
                        subview.frame = CGRect(x: textFieldContentInset.left, y: textFieldContentInset.top, width: self.bounds.width - textFieldContentInset.left - textFieldContentInset.right, height: self.bounds.height - textFieldContentInset.top - textFieldContentInset.bottom)
                    } else { // 若contentSet未被赋值
                        // 设置UISearchBar中UISearchBarTextField的默认边距
                        let top: CGFloat = (self.bounds.height - 28.0) / 2.0
                        let bottom: CGFloat = top
                        let left: CGFloat = 8.0
                        let right: CGFloat = left
                        contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
                    }
                }
            }
        }
    }
}


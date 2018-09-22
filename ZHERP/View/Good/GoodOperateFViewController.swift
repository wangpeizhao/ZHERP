//
//  GoodOperateFViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/21.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

// 添加编辑货品数据类型
// - category: 货品分类
// - warehouse: 所属仓库
// - location: 所属库位
enum GoodOperateType {
    case category
    case warehouse
    case location
    case supplier
    case unit
}

class GoodOperateFViewController: UIViewController {
    
    var Id: Int = 0
    var navTitle: String? = nil
    var dataType: GoodOperateType!
    var sn: String!
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    var selectedIds = [Int]()
    
    var dataArr: [[String: String]]!
    
    // Array
    var callBackAssignArray: assignArrayClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle!)
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        self._setup()
    }
    
    @objc func actionBack() {
        
    }
    
    fileprivate func _initData(type: GoodOperateType) {
        switch type {
        case .category:
            self._initDataCategory()
        case .warehouse:
            self._initDataWarehouse()
        case .location:
            self._initDataLocation()
        case .supplier:
            self._initDataSupplier()
        case .unit:
            self._initDataUnit()
        }
    }
    
    fileprivate func _initDataCategory() {
        self.dataArr = [
//            ["name":"顶级", "id":"0", "depth": "1", "pId": "0"],
            ["name":"男装", "id":"1", "depth": "1", "pId": "0"],
            ["name":"T恤", "id":"2", "depth": "2", "pId": "1"],
            ["name":"短袖T恤", "id":"3", "depth": "3", "pId": "2"],
            ["name":"红色短袖T恤", "id":"4", "depth": "4", "pId": "3"],
            ["name":"白色短袖T恤", "id":"5", "depth": "4", "pId": "3"],
            ["name":"珍珠白短袖T恤", "id":"8", "depth": "5", "pId": "5"],
            ["name":"长袖T恤", "id":"6", "depth": "3", "pId": "2"],
            ["name":"女装", "id":"7", "depth": "1", "pId": "0"],
            ["name":"连衣裙", "id":"9", "depth": "2", "pId": "7"],
            ["name":"短袖连衣裙", "id":"10", "depth": "3", "pId": "9"],
            ["name":"长裙连衣裙", "id":"11", "depth": "3", "pId": "9"],
            ["name":"衬衫", "id":"12", "depth": "2", "pId": "7"],
            ["name":"短袖衬衫", "id":"13", "depth": "3", "pId": "12"],
            ["name":"童装", "id":"14", "depth": "1", "pId": "0"],
            ["name":"裤子", "id":"15", "depth": "2", "pId": "14"],
            ["name":"长裤", "id":"16", "depth": "3", "pId": "15"],
            ["name":"裙子", "id":"17", "depth": "2", "pId": "14"],
            ["name":"连衣裙", "id":"18", "depth": "3", "pId": "17"]
        ]
    }
    
    fileprivate func _initDataWarehouse() {
        self.dataArr = [
            ["name":"默认仓库", "id":"1"],
            ["name":"深圳仓库", "id":"2"],
            ["name":"日照仓库", "id":"3"],
            ["name":"厦门仓库", "id":"4"],
            ["name":"湛江仓库", "id":"5"]
        ]
    }
    
    fileprivate func _initDataLocation() {
        self.dataArr = [
            ["name":"默认仓库", "id":"1", "warehouse":"默认仓库", "wId": "1"],
            ["name":"南山仓库", "id":"2", "warehouse":"深圳仓库", "wId": "2"],
            ["name":"五莲仓库", "id":"3", "warehouse":"日照仓库", "wId": "3"],
            ["name":"同安仓库", "id":"4", "warehouse":"厦门仓库", "wId": "4"],
            ["name":"廉江仓库", "id":"5", "warehouse":"湛江仓库", "wId": "5"]
        ]
    }
    
    fileprivate func _initDataSupplier() {
        self.dataArr = [
            ["name":"三星(广州)", "id":"1", "region":"", "province":"广东", "city":"广州", "area":"海珠区", "detail":"海珠大街15号", "username": "三星CEO", "telephone": "12345678"],
            ["name":"腾讯(深圳)", "id":"2", "region":"", "province":"广东", "city":"深圳", "area":"南山区", "detail":"南山大街11号", "username": "腾讯CEO", "telephone": "12345678"],
            ["name":"华为(日照)", "id":"3", "region":"", "province":"山东", "city":"日照", "area":"五莲县", "detail":"五莲大街101号", "username": "华为CEO", "telephone": "12345678"],
            ["name":"京东(厦门)", "id":"4", "region":"", "province":"福建", "city":"厦门", "area":"同安区", "detail":"同安大街21号", "username": "京东CEO", "telephone": "12345678"],
            ["name":"阿里巴巴(湛江)", "id":"5", "region":"", "province":"广东", "city":"湛江", "area":"廉江市", "detail":"廉江大街10号", "username": "阿里巴巴CEO", "telephone": "12345678"]
        ]
    }
    
    fileprivate func _initDataUnit() {
        self.dataArr = [
            ["name":"克", "id":"1"],
            ["name":"车", "id":"2"],
            ["name":"个", "id":"3"],
            ["name":"件", "id":"4"],
            ["name":"米", "id":"5"],
            ["name":"克", "id":"6"],
            ["name":"千克", "id":"7"],
            ["name":"袋", "id":"8"],
            ["name":"包", "id":"9"],
            ["name":"把", "id":"10"]
        ]
    }
    
    private func _setup() {
        
        self._initData(type: dataType)
        
        self._getSelectedIndexs()
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
    }
    
    // 获取选中索引
    private func _getSelectedIndexs() {
        if self.dataArr.count == 0 || self.selectedIds.count == 0 {
            return
        }
        for (index, item) in self.dataArr.enumerated() {
            let _id = item["id"]!
            if self.selectedIds.contains(Int(_id)!) {
                self.selectedIndexs.append(index)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GoodOperateFViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "请\(self.navTitle ?? "")"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = _data["name"]
        cell.textLabel?.font = Specs.font.regular
        cell.textLabel?.sizeToFit()
        
        if self.dataType == .category {
            cell.indentationLevel =  (Int(_data["depth"]!)! - 1)  //缩进层级
            cell.indentationWidth = Int(_data["depth"]!) == 1 ? 20 : 10  //每次缩进寛
        }
        
        //判断是否选中（选中单元格尾部打勾）
        if selectedIndexs.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _data = dataArr[indexPath.item]
        
        selectedIndexs.removeAll() // 单选
        selectedIndexs.append(indexPath.row)
        
        self.tableView?.reloadData()
        
        if self.dataType == .category {
            let _target = GoodOperateSViewController()
            _target.valueArr["cId"] = _data["id"]
            if self.sn != nil {
                _target.valueArr["sn"] = self.sn
            }
            _target.navTitle = "添加货品"
            _push(view: self, target: _target)
            return
        }
        if (self.callBackAssignArray != nil) {
            self.callBackAssignArray!(_data)
        }
        
        _back(view: self)
    }
}

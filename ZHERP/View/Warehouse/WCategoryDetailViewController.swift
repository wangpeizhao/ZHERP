//
//  WCategoryDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WCategoryDetailViewController: UIViewController {
    
    var Id: Int = 0
    var navTitle: String? = nil
    var value: String? = nil
    var placeholder: String? = nil
    var navHeight: CGFloat!
    
    var isSelectList: Bool = false
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    var selectedIds = [Int]()
    
    var dataArr: [[String: String]]!
    
    let _value = UITextField()
    // String
    var callBackAssign: assignValueClosure?
    // Array
    var callBackAssignArray: assignArrayClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle!)
        // setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
        if self.isSelectList {
            self._setSelectList()
        } else {
            self._setup()
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        let value = self._value.text
        if (value?.isEmpty)! {
            _alert(view: self, message: "\(self.navTitle!)不能为空！")
            return
        }
        if (self.callBackAssign != nil) {
            self.callBackAssign!(value!)
        }
        _back(view: self)
    }
    
    private func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        let _view = UIView(frame: CGRect(x: 0, y: self.navHeight + 10, width: ScreenWidth, height: 40))
        _view.backgroundColor = Specs.color.white
        self.view.addSubview(_view)
        
        self._value.text = self.value
        self._value.placeholder = self.placeholder
        self._value.textAlignment = .left
        self._value.font = Specs.font.regular
        self._value.textColor = Specs.color.gray
        self._value.clearButtonMode = .whileEditing
        self._value.becomeFirstResponder() // resignFirstResponder
        _view.addSubview(self._value)
        self._value.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.right.equalTo(-10)
            make.centerY.equalTo(_view)
        }
        
        let _btn = UIButton(frame: CGRect(x: 10, y: self.navHeight + 60, width: ScreenWidth - 20, height: 40))
        _btn.setTitle("保存", for: .normal)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _btn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        self.view.addSubview(_btn)
    }
    
    private func _setSelectList() {
        self.dataArr = [
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

extension WCategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "请选择所属分类"
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
        cell.indentationLevel =  (Int(_data["depth"]!)! - 1)  //缩进层级
        cell.indentationWidth = 20  //每次缩进寛
        
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
        
        if (self.callBackAssignArray != nil) {
            self.callBackAssignArray!(_data)
        }
        
        _back(view: self)
    }
}

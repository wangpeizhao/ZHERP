//
//  WarehouseLocationViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/1.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WarehouseLocationViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    let dataArr = [
        ["name":"默认仓库", "id":"1","address":"默认仓库"],
        ["name":"东莞大仓", "id":"2","address":"海珠仓"],
        ["name":"珠海大仓", "id":"3","address":"广州海珠"],
        ["name":"京东大东仓库", "id":"4","address":"广州海珠"],
        ["name":"广州海珠中大轻纺交易1306", "id":"5","address":"广州萝岗广州萝岗广州萝岗广州萝岗广州萝岗"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "仓库管理")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionAdd() {
        
    }
    
    private func _setup() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
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

extension WarehouseLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return "选项前往添加、更新、删除"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //将分组尾设置为一个空的View
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    //    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
//        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath)
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CELL_IDENTIFY_ID)
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)

        cell.textLabel?.text = _data["name"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _data["address"]!
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.tag = Int(_data["id"]!)!
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let _target = ZHQRCodeViewController()
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: true)
        
    }
}

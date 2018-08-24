//
//  OrderAllViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class OrderUnpayViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var dataArray : [Int: [String:String]] = [
        0: ["imagePath": "html", "suk": "AB_PPC01", "title": "六神花露水001", "price": "17.50","orderId": "ZH201808242256"],
        1: ["imagePath": "java", "suk": "BC_PPC02", "title": "六神花露水002", "price": "17.50","orderId": "ZH201808242256"],
        2: ["imagePath": "bayMax", "suk": "CD_PPC03", "title": "六神花露水003", "price": "17.50","orderId": "ZH201808242256"],
        3: ["imagePath": "php", "suk": "DE_PPC04", "title": "六神花露水004", "price": "17.50","orderId": "ZH201808242256"],
        4: ["imagePath": "bayMax", "suk": "EF_PPC05", "title": "六神花露水005", "price": "17.50","orderId": "ZH201808242256"],
        5: ["imagePath": "react", "suk": "FG_PPC06", "title": "六神花露水006", "price": "17.50","orderId": "ZH201808242256"],
        6: ["imagePath": "ruby", "suk": "GH_PPC07", "title": "六神花露水007", "price": "17.50","orderId": "ZH201808242256"],
        7: ["imagePath": "swift", "suk": "HI_PPC08", "title": "六神花露水008", "price": "17.50","orderId": "ZH201808242256"],
        8: ["imagePath": "xcode", "suk": "IJ_PPC09", "title": "六神花露水009", "price": "17.50","orderId": "ZH201808242256"],
        9: ["imagePath": "bayMax", "suk": "JK_PPC10", "title": "六神花露水010", "price": "17.50","orderId": "ZH201808242256"],
        10: ["imagePath": "bayMax", "suk": "KL_PPC11", "title": "六神花露水011", "price": "17.50","orderId": "ZH201808242256"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    private func _setup() {
        // 创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.tableView?.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.view.addSubview(self.tableView!)
    }
    
    @objc func actionBack() {
        
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


extension OrderUnpayViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.1 : 8.0
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let count = self.dataArray.count
            let sectionNo = count - indexPath.row - 1
            print(sectionNo)
            let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID) as! OrderTableViewCell
            if !(self.dataArray[sectionNo]?.isEmpty)! {
                var _data = self.dataArray[sectionNo]!
                
                cell.orderImage.image = UIImage(named: _data["imagePath"]!)
                cell.sukLabel.text = _data["suk"]
                cell.titleLabel.text = _data["title"]
                cell.priceLabel.text = _data["price"]
                cell.orderId.text = _data["orderId"]
                cell.accessoryType = .disclosureIndicator
            }
            return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "订单", selector: selector)
        _push(view: self, target: orderView, rootView: true)
    }
}

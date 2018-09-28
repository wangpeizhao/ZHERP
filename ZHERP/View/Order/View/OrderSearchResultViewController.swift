//
//  OrderSearchResultViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/9.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class OrderSearchResultViewController: UIViewController {
    
    let identify = "orderSearchResultCell"
    var tableView: UITableView?
    var dataArray : [Int: [String:String]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        self.dataArray = [
            0: ["imagePath": "bayMax", "suk": "QQ_PPC01", "title": "六神花露水", "price": "17.50"],
            1: ["imagePath": "bayMax", "suk": "QQ_PPC02", "title": "六神花露水", "price": "17.50"]
        ]
                
        let historyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 25))
        historyLabel.text = "搜索结果"
        self.view.addSubview(historyLabel)
//        historyLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(0)
//            make.left.right.equalTo(0)
//            make.height.equalTo(25)
//        }

        // 创建表视图
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style:.grouped)
        // 去除表格上放多余的空隙
//        self.tableView!.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //去除单元格分隔线
        self.tableView!.separatorStyle = .singleLine
        self.tableView!.tableFooterView = UIView(frame: .zero)
        self.tableView!.tableHeaderView = UIView(frame: .zero)
        
        self.tableView?.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: identify)
        self.view.addSubview(self.tableView!)
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
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

extension OrderSearchResultViewController: UITableViewDataSource ,UITableViewDelegate {
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    //
    //    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "搜索结果"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "开启后，手机不会振动与发出提示音；如果设置为“只在夜间开启”，则只在22:00到08:00间生效"
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let count = self.dataArray.count
            let sectionNo = count - indexPath.row - 1
            let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: identify) as! OrderTableViewCell
            if !((self.dataArray[sectionNo]?.isEmpty)!) {
                var _data = self.dataArray[sectionNo]!
                
                cell.orderId.text = _data["orderId"]
                cell.orderId.sizeToFit()
                cell.orderTime.text = _data["orderTime"]
                cell.orderTime.sizeToFit()
                cell.orderTotal.text = _data["orderTotal"]
                cell.orderTotal.sizeToFit()
                cell.orderAmount.text = _data["orderAmount"]
                cell.orderAmount.sizeToFit()
                cell.orderStatus.text = _data["orderStatus"]
                cell.orderStatus.sizeToFit()
                cell.orderQuantity.text = _data["orderQuantity"]
                cell.orderQuantity.sizeToFit()
                cell.orderDiscounts.text = _data["orderDiscounts"]
                cell.orderId.sizeToFit()
                
                cell.accessoryType = .disclosureIndicator
            }
            print("self.dataArray.count")
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
//        orderView.navTitle = _data["suk"]
//        orderView.order_image = _data["imagePath"]
//        orderView.order_price = _data["price"]
//        orderView.order_title = _data["title"]
//        orderView.actionValue = ""
        
        //        _push(view: self, target: orderView, rootView: true)
        self.presentingViewController?.navigationController?.pushViewController(orderView, animated: true)
    }
}

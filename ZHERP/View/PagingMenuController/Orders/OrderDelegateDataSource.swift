//
//  OrderDelegateDataSource.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/26.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class OrderDelegateDataSource: UIViewController {
    
    var dataArr = [[String: String]]()
    var CELL_IDENTIFY_ID: String!
    var orderType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension OrderDelegateDataSource: UITableViewDataSource ,UITableViewDelegate {
    
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! OrderTableViewCell
        
        let _data = dataArr[indexPath.item]
        cell.orderId.text = _data["orderId"]
        cell.orderId.sizeToFit()
        cell.orderTime.text = _data["orderTime"]
        cell.orderTime.sizeToFit()
        cell.orderTotal.text = "总价:" + _data["orderTotal"]!
        cell.orderTotal.sizeToFit()
        cell.orderAmount.text = "实收:" + _data["orderAmount"]!
        cell.orderAmount.sizeToFit()
        cell.orderStatus.text = "状态:" + _data["orderStatus"]!
        cell.orderStatus.sizeToFit()
        cell.orderQuantity.text = "数量:" + _data["orderQuantity"]!
        cell.orderQuantity.sizeToFit()
        cell.orderDiscounts.text = "优惠:" + _data["orderCoupon"]!
        cell.orderId.sizeToFit()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let _target = OrderDetailViewController()

        let _data = dataArr[indexPath.item]
        
        var status: String = ""
        if self.orderType != "" {
            status = "paid"
            _target.orderType = self.orderType
        } else {
            let orderStatus = ["active","paid","cancel","delivered","refund"]
            let index = arc4random_uniform(UInt32(orderStatus.count))
            status = orderStatus[Int(index)]
        }

        _target.valueArr = [
            "orderId": _data["orderId"],
            "orderTime": "2018-09-27 10:34:32",
            "orderStatus": status,
            "orderTotal": "12345.09",
            "orderCoupon": "100.00",
            "orderAmount": _data["orderAmount"],
            "orderQuantity": "10",
            "orderEmployee": "Parker",
            "orderType": self.orderType,
            "receiver": "王培照",
            "receiverPhone": "15622299006",
            "receiverRegion": "广东省,广州市,天河区",
            "receiverDetail": "天河公园北门100号",
            "expressCompany": "顺丰",
            "expressNumber": "SFDHDHDJFJ32423",
            "expressNote": "当天到达",
            "expressEmployee": "照哥",
            "expressDatetime": "2018-09-26 10:34:32"
            ] as! [String : String]
        if self.orderType != "" {
            _push(view: self, target: _target, rootView: false)
        } else {
            globalViewControllerForHiddenTabBar.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(_target, animated: true)
            globalViewControllerForHiddenTabBar.hidesBottomBarWhenPushed = false
        }
    }
}

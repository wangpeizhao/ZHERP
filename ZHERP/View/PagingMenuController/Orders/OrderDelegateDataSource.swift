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
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! OrderTableViewCell
        
        let _data = dataArr[indexPath.item]
            
        cell.orderImage.image = UIImage(named: _data["imagePath"]!)
        cell.sukLabel.text = _data["suk"]
        cell.titleLabel.text = _data["title"]
        cell.priceLabel.text = _data["price"]
        cell.orderId.text = _data["orderId"]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let _target = OrderDetailViewController()

        let _data = dataArr[indexPath.item]
        
//        let selector: Selector = #selector(actionBack)
//        setNavBarBackBtn(view: self, title: "订单", selector: selector)
        _push(view: self, target: _target, rootView: false)
    }
}

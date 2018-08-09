//
//  OrderSearchResultViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/9.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class OrderSearchResultViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    let identify = "orderSearchResultCell"
    var tableView: UITableView?
    var dataArray : [Int: [String:String]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            0: ["imagePath": "bayMax", "suk": "QQ_PPC01", "title": "六神花露水", "price": "17.50"],
            1: ["imagePath": "bayMax", "suk": "QQ_PPC02", "title": "六神花露水", "price": "17.50"]
        ]
        
        // 创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
        // 去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //去除单元格分隔线
        self.tableView!.separatorStyle = .singleLine
        
        self.tableView?.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: identify)
        self.view.addSubview(self.tableView!)
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view.
    }
    
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
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return tableView.sectionHeaderHeight + 50
    //    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        return "开启后，手机不会振动与发出提示音；如果设置为“只在夜间开启”，则只在22:00到08:00间生效"
    //    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let count = self.dataArray.count
            let sectionNo = count - indexPath.row - 1
            print(sectionNo)
            let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: identify) as! OrderTableViewCell
            if !((self.dataArray[sectionNo]?.isEmpty)!) {
                var _data = self.dataArray[sectionNo]!
                print(_data)
                //            let _data = data[indexPath.row as Int]
                //            //为了提供表格显示性能，已创建完成的单元需重复使用
                //            //同一形式的单元格重复使用，在声明时已注册
                
                cell.orderImage.image = UIImage(named: _data["imagePath"]!)
                cell.sukLabel.text = _data["suk"]
                cell.titleLabel.text = _data["title"]
                cell.priceLabel.text = _data["price"]
                cell.accessoryType = .disclosureIndicator
            }
            return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderView = OrderDetailViewController()
        orderView.hidesBottomBarWhenPushed = true
        //        _push(view: self, target: OrderDetailViewController(), rootView: true)
        
        let count = self.dataArray.count
        let sectionNo = count - indexPath.row - 1
        var _data = self.dataArray[sectionNo]!
        orderView.navTitle = _data["title"]
//        orderView.orderImage.image = UIImage(named: _data["imagePath"]!)
        orderView.order_price = _data["price"]
        orderView.order_title = _data["title"]
        self.navigationController?.pushViewController(orderView, animated: true)
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

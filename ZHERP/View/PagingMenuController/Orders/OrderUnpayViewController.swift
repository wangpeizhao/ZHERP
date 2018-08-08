//
//  OrderAllViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class OrderUnpayViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    var tableView: UITableView?
    let identify: String = "OrderCell"
    var dataArray: [Int: [String:String]] = [
        0: ["imagePath": "bayMax", "suk": "RR_PPC001", "title": "六神花露水", "price": "17.50"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self.dataArray)
        //        //创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
        //        //去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //去除单元格分隔线
        self.tableView!.separatorStyle = .singleLine
        
        //        self.tableView!.rowHeight = UITableViewAutomaticDimension;
        
        //设置estimatedRowHeight属性默认值
        //        self.tableView.estimatedRowHeight = 44.0;
        //rowHeight属性设置为UITableViewAutomaticDimension
        //        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //创建一个重用的单元格
        //        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        self.tableView?.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: identify)
        //        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView!)
        
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
            let sectionNo = indexPath.section
            var _data = self.dataArray[sectionNo]!
            //            print(data)
            //            let _data = data[indexPath.row as Int]
            //            //为了提供表格显示性能，已创建完成的单元需重复使用
            //            //同一形式的单元格重复使用，在声明时已注册
            let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: identify) as! OrderTableViewCell
            cell.orderImage.image = UIImage(named: _data["imagePath"]!)
            cell.sukLabel.text = _data["suk"]
            cell.titleLabel.text = _data["title"]
            cell.priceLabel.text = _data["price"]
            return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //判断该行原先是否选中
    //        if let index = selectedIndexs.index(of: indexPath.row){
    //            selectedIndexs.remove(at: index) //原来选中的取消选中
    //        }else{
    //            selectedIndexs.removeAll() // 单选
    //            selectedIndexs.append(indexPath.row) //原来没选中的就选中
    //        }
    //
    //        //刷新该行
    //        //        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
    //
    //        self.tableView?.reloadData()
    //    }
    
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

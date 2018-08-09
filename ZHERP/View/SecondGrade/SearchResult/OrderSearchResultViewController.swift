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
        
        let selector: Selector = #selector(actionBack)
//        setNavBarBackBtn(view: self, title: "订单", selector: selector)
//        NSLog(@"%ld %ld",indexPath.section,indexPath.item);
//        DetailViewController *detail = [[DetailViewController alloc] init] ;
//        CollectionModel *model = [[CollectionModel alloc] init];
//        model = self.searchResults[indexPath.item];
//        detail.name = model.imageName;
//        [self.presentingViewController.navigationController pushViewController:detail animated:YES];
//
//        NSLog(@"%ld %ld",indexPath.section,indexPath.item);
//        DetailViewController *detail = [[DetailViewController alloc] init] ;
//        CollectionModel *model = [[CollectionModel alloc] init];
//        model = self.dataArray[indexPath.item];
//        detail.name = model.imageName;
//        [self.navigationController pushViewController:detail animated:YES];
//
//        作者：Xcode8
//        链接：https://www.jianshu.com/p/45c97fe3b65f
//        來源：简书
//        简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
//        let order = OrderViewController()
//        order.searchController.searchBar.resignFirstResponder()
        
        let item = UIBarButtonItem(title: "订单", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
//        _push(view: self, target: orderView, rootView: true)
        self.presentingViewController?.navigationController?.pushViewController(orderView, animated: true)
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

//
//  StatisticNavigationViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/7.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class StatisticNavigationViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView:UICollectionView?
    let CELL_CVIEW_ID = "cellCollectView"
    
    let courses = [
        ["name":"日销售报表", "key":"picking","pic":"ruby.png"],
        ["name":"店铺订单量", "key":"scanSendGood","pic":"html.png"],
        ["name":"店铺销售汇总", "key":"allocating","pic":"c#.png"],
        ["name":"货品销售排行", "key":"warehouse","pic":"js.png"],
        ["name":"盘点", "key":"takeStock","pic":"react.png"],
        ["name":"经营分析", "key":"setting","pic":"php.png"],
        ["name":"Ruby", "key":"","pic":"ruby.png"],
        ["name":"HTML", "key":"","pic":"html.png"],
        ["name":"C#", "key":"","pic":"c#.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    func _setup() {
        let layout = UICollectionViewFlowLayout()
        //间隔
        let spacing:CGFloat = 2
        //水平间隔
        layout.minimumInteritemSpacing = spacing
        //垂直行间距
        layout.minimumLineSpacing = spacing
        
        //列数
        let columnsNum = 3
        //整个view的宽度
        let collectionViewWidth = ScreenWidth
        //计算单元格的宽度
        let itemWidth = (collectionViewWidth - spacing * CGFloat(columnsNum-1)) / CGFloat(columnsNum)
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth, height:100)
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView!.backgroundColor = UIColor(hex: 0xfcfcfc)
        
        collectionView!.delegate = self
        
        collectionView!.dataSource = self
        
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: CELL_CVIEW_ID)
        self.view.addSubview(collectionView!)
        
    }
    
    //获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_CVIEW_ID, for: indexPath) as! HomeCollectionViewCell
        cell.imageName = courses[indexPath.item]["pic"]
        cell.imageTitle = courses[indexPath.item]["name"]
        cell.imageLabel?.text = courses[indexPath.item]["name"]
        cell.imageView?.image = UIImage(named: courses[indexPath.item]["pic"]!)
        cell.isHighlighted = true
        return cell;
        
    }
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key: String = courses[indexPath.item]["key"]!
        switch key {
        case "scanSendGood":
            let _target = ZHQRCodeViewController()
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: true)
        case "warehouse":
            let _target = WarehouseViewController()
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: true)
        case "setting":
            let _target = SettingsViewController()
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: true)
        default:
            let _target = GoodDetailViewController()
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

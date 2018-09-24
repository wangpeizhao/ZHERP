//
//  GoodOperateImageView.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/23.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

protocol GoodOperateImageViewDelegate : NSObjectProtocol {
    func didSelectItemAtImage(view: GoodOperateImageView, row: Int)
}

class GoodOperateImageView: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var _delegate: GoodOperateImageViewDelegate?
    
    var collectionView:UICollectionView?
    let CELL_CVIEW_ID = "cellCollectView"
    
//    let dataArr = [
//        ["name":"拣货", "key":"picking","pic":"swift.png"],
//        ["name":"扫码发货", "key":"deliver","pic":"xcode.png"],
//        ["name":"调货", "key":"allocate","pic":"java.png"],
//        ["name":"仓库", "key":"warehouse","pic":"php.png"],
//        ["name":"盘点", "key":"inventory","pic":"js.png"],
//        ["name":"设置", "key":"setting","pic":"react.png"],
//        ["name":"Ruby", "key":"","pic":"ruby.png"],
//        ["name":"HTML", "key":"","pic":"html.png"],
//        ["name":"C#", "key":"","pic":"c#.png"]
//    ]
    var dataArr:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 0)
        self.view.backgroundColor = UIColor.red
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
        let columnsNum = 4
        //整个view的宽度
        let collectionViewWidth = ScreenWidth
        //计算单元格的宽度
        let itemWidth = (collectionViewWidth - spacing * CGFloat(columnsNum-1)) / CGFloat(columnsNum)
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth, height:78)
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: (self.dataArr.count > 4 ? 166 : 88))
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView!.backgroundColor = UIColor(hex: 0xfcfcfc)
        
        collectionView!.delegate = self
        
        collectionView!.dataSource = self
        
        collectionView!.register(GoodOperateImageViewCell.self, forCellWithReuseIdentifier: CELL_CVIEW_ID)
        self.view.addSubview(collectionView!)
//        collectionView?.reloadData()
    }
    
    //获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GoodOperateImageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_CVIEW_ID, for: indexPath) as! GoodOperateImageViewCell
        print(self.dataArr)
        cell.imageView?.image = self.dataArr[indexPath.item] // UIImage(named: self.dataArr[indexPath.item]["pic"]!)
        cell.isHighlighted = true
        if indexPath.row == 0 {
//            cell.deleteBtn.isHidden = true
        } else {
            cell.deleteBtn?.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
        }
        return cell;
        
    }
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let key: String = self.dataArr[indexPath.item]["key"]!
//        var _target: UIViewController!
        if (self._delegate != nil) {
            self._delegate?.didSelectItemAtImage(view: self, row: indexPath.row)
        }
    }
    
    @objc func actionDelete() {
        print("actionDelete")
        _confirm(view: self, title: "提示", message: "确定要删除这张图片吗？", handler: _actionDelete)
    }
    
    func _actionDelete(_: UIAlertAction)->Void {
        print("actionDelete")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

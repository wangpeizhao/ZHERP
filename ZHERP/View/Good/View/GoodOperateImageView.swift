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
    func deleteGoodImage(view: GoodOperateImageView, row: Int)
}

class GoodOperateImageView: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var _delegate: GoodOperateImageViewDelegate?
    
    var collectionView:UICollectionView?
    let CELL_CVIEW_ID = "cellCollectView"
    
    var deleteGoodImageRow: Int? = nil
    // 最多允许上传照片数量
    var maxGoodImages: Int = 8
    
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
        self.view.backgroundColor = UIColor.clear
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    func _setup() {
        self._goodImageTipView()
        
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
        let frame = CGRect(x: 0, y: 60, width: ScreenWidth, height: (self.dataArr.count > 4 ? 166 : 88))
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView!.backgroundColor = UIColor(hex: 0xfcfcfc)
        
        collectionView!.delegate = self
        
        collectionView!.dataSource = self
        
        collectionView!.register(GoodOperateImageViewCell.self, forCellWithReuseIdentifier: CELL_CVIEW_ID)
        self.view.addSubview(collectionView!)
//        collectionView?.reloadData()
    }
    
    fileprivate func _goodImageTipView() {
        let _tipView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
        _tipView.backgroundColor = UIColor.hexInt(0xfff0ba)
        self.view.addSubview(_tipView)
        
        let _tipLabel = UILabel()
        _tipView.addSubview(_tipLabel)
        _tipLabel.sizeToFit()
        _tipLabel.textAlignment = .left
        _tipLabel.font = Specs.font.regular
        _tipLabel.textColor = UIColor.hexInt(0xab7548)
        _tipLabel.text = "温馨提示：货品照片最多允许上传\(self.maxGoodImages)张；自动截取成正方形"
        _tipLabel.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(10)
        }
        
        let _tip2Label = UILabel()
        _tipView.addSubview(_tip2Label)
        _tip2Label.sizeToFit()
        _tip2Label.textAlignment = .left
        _tip2Label.font = Specs.font.regular
        _tip2Label.textColor = UIColor.hexInt(0xab7548)
        _tip2Label.text = "长按图片可更换位置"
        _tip2Label.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(90)
            make.right.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(30)
        }
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

        cell.imageView?.image = self.dataArr[indexPath.item] // UIImage(named: self.dataArr[indexPath.item]["pic"]!)
        cell.isHighlighted = true
        if indexPath.row == self.dataArr.count - 1 {
            cell.deleteBtn?.isHidden = true
        } else {
            cell.deleteBtn?.addTarget(self, action: #selector(actionDelete(_:)), for: .touchUpInside)
            cell.deleteBtn?.tag = indexPath.row
        }
        return cell;
        
    }
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self._delegate != nil) {
            self._delegate?.didSelectItemAtImage(view: self, row: indexPath.row)
        }
    }
    
    @objc func actionDelete(_ sender: UIButton) {
        self.deleteGoodImageRow = sender.tag
        _confirm(view: self, title: "提示", message: "确定要删除这张照片吗？", handler: _actionDelete(_:))
    }
    
    func _actionDelete(_: UIAlertAction)->Void {
        if (self._delegate != nil) {
            self._delegate?.deleteGoodImage(view: self, row: self.deleteGoodImageRow!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

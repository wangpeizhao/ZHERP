//
//  HomeNavigationViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/20.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HomeNavigationViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView:UICollectionView?
    let CELL_CVIEW_ID = "cellCollectView"
    var _height: CGFloat = 400.0
    
    let navs = [
        ["name":"拣货", "key":"picking","pic":"swift.png"],
        ["name":"扫码发货", "key":"deliver","pic":"xcode.png"],
        ["name":"调货", "key":"allocate","pic":"java.png"],
        ["name":"仓库管理", "key":"warehouse","pic":"php.png"],
        ["name":"盘点", "key":"inventory","pic":"js.png"],
        ["name":"入仓", "key":"warehousing","pic":"c#.png"],
        ["name":"历史账单", "key":"bill","pic":"ruby.png"],
        ["name":"订单发货", "key":"delivering","pic":"html.png"],
        ["name":"设置", "key":"setting","pic":"react.png"],
        ["name":"收钱啦", "key":"receipt","pic":"java.png"],
        ["name":"退货", "key":"refund","pic":"php.png"],
        ["name":"使用帮助", "key":"help","pic":"html.png"],
        ["name":"打印条码", "key":"bar","pic":"java.png"],
        ["name":"条码模块", "key":"barModule","pic":"java.png"],
        ["name":"打印记录", "key":"barLog","pic":"java.png"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self._setTrajectory()
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setTrajectory() {
        let _chartsView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 70))
        self.view.addSubview(_chartsView)
        
        let _charts = HomeChartsViewController()
        self.addChildViewController(_charts)
        _chartsView.addSubview(_charts.view)
        
        
        let cgView = UIView(frame: CGRect(x: 0, y: 70, width: ScreenWidth, height: 80))
        cgView.backgroundColor = UIColor.white
        self.view.insertSubview(cgView, belowSubview: _chartsView)
        
        let ellipse = CGView(frame: CGRect(x: -20, y: -70, width: ScreenWidth + 40, height: 100))
        cgView.addSubview(ellipse)
    }
    
    fileprivate func _setup() {
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
        let frame = CGRect(x: 0, y: 70, width: ScreenWidth, height: self._height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView!.backgroundColor = UIColor.clear
        
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
        return self.navs.count
    }
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_CVIEW_ID, for: indexPath) as! HomeCollectionViewCell
        cell.imageName = self.navs[indexPath.item]["pic"]
        cell.imageTitle = self.navs[indexPath.item]["name"]
        cell.imageLabel?.text = self.navs[indexPath.item]["name"]
        cell.imageView?.image = UIImage(named: self.navs[indexPath.item]["pic"]!)
        cell.isHighlighted = true
        return cell;
        
    }
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key: String = self.navs[indexPath.item]["key"]!
        var _target: UIViewController!
        switch key {
        case "picking":
            _target = HPickingViewController()
        case "deliver":
            let _target = ZHQRCodeViewController()
            _target.actionType = "delivering"
            _target.navTitle = "扫码发货"
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: true)
            return
        case "allocate":
            _target = HAllocateViewController()
        case "warehouse":
            _target = WarehouseViewController()
        case "inventory":
            _target = HInventoryViewController()
        case "setting":
            _target = SettingsViewController()
        case "bill":
            _target = OrderBillsViewController()
        case "delivering":
            _target = HDeliverViewController()
        case "warehousing":
            let _target = GoodOperateFViewController()
            _target.dataType = .category
            _target.navTitle = "选择货品分类"
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: true)
            return
        case "receipt":
            _target = HReceiptViewController()
        case "refund":
            _target = OrderRefundViewController()
        case "help":
            _target = SResponsibilityViewController()
        case "bar":
            _target = QRBarCodeViewController()
        case "barModule":
            _target = QRBarCodeViewController()
        case "barLog":
            _target = QRBarCodeViewController()
        default:
            _target = GoodDetailViewController()
        }
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CGView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //创建一个矩形，它的所有边都内缩3点
        let drawingRect = self.bounds.insetBy(dx: 0, dy: 0)

        //创建并设置路径
        let path = CGMutablePath()
        //绘制椭圆
        path.addEllipse(in: drawingRect)

        //添加路径到图形上下文
        context.addPath(path)

        //设置填充颜色
        context.setFillColor(UIColor(hex: 0x1a2639).cgColor)

        //绘制路径并填充
        context.drawPath(using: .fillStroke)
    }
}

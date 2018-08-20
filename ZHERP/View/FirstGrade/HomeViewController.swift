//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var pickingBtn: UIButton!
    @IBOutlet weak var scanSendGoodBtn: UIButton!
    @IBOutlet weak var allocatingBtn: UIButton!
    @IBOutlet weak var warehouseBtn: UIButton!
    @IBOutlet weak var takeStockBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var functionalBlock: UIView!
    @IBOutlet weak var homeNavBar: UINavigationBar!
    @IBOutlet weak var rankingBlock: UIView!
    @IBOutlet weak var todayBlock: UIView!
    
    @IBOutlet weak var todayTotalAmount: UILabel!
    @IBOutlet weak var historyShipments: UILabel!
    @IBOutlet weak var todayShipments: UILabel!
    @IBOutlet weak var residueShipments: UILabel!
    //    @IBOutlet weak var todayShipments: UILabel!
//    @IBOutlet weak var residueShipments: UILabel!
    
    
    @IBAction func memberCenter(_ sender: Any) {
        if(checkLoginStatus()) {
//            _push(view: self, target: MemberViewController(), rootView: true)
            _push(view: self, target: RegisteringViewController(), rootView: true)
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
    
    @IBAction func PickingBtnClicked(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        _push(view: self, target: OrderAllViewController(), rootView: true)
    }
    @IBAction func ScanSendGoodBtnClicked(_ sender: Any) {
//        let qrcodeImg = UIImage(named: "codeBg.png")
//        let ciImage: CIImage = CIImage(image: qrcodeImg!)!
//        
//        let context = CIContext(options: nil)
//        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
//        
//        let features = detector?.features(in: ciImage)
//        print("扫描到二维码个数：\(features?.count ?? 0)")
//        //遍历所有的二维码，并框出
//        for feature in features as! [CIQRCodeFeature] {
//            print(feature.messageString ?? "")
//        }
        self.hidesBottomBarWhenPushed = true
        _push(view: self, target: ZHQRCodeViewController(), rootView: true)
    }
    @IBAction func AllocatingBtnClicked(_ sender: Any) {
    }
    @IBAction func WarehouseBtnClicked(_ sender: Any) {
    }
    @IBAction func TakeStockBtnClicked(_ sender: Any) {
    }
    @IBAction func SettingBtnClicked(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        _push(view: self, target: GoodDetailViewController(), rootView: true)
    }
    
    var vc: UIViewController!
    var withNav: Bool!
    
    @IBOutlet weak var homeTxt: UIButton!
    
    
    
    var collectionView:UICollectionView?
    let CELL_CVIEW_ID = "cellCollectView"
    let ScreenHeight = UIScreen.main.bounds.size.height
    let ScreenWidth = UIScreen.main.bounds.size.width
    
    let courses = [
        ["name":"Swift", "key":"","pic":"swift.png"],
        ["name":"扫描", "key":"scan","pic":"xcode.png"],
        ["name":"Java", "key":"","pic":"java.png"],
        ["name":"PHP", "key":"","pic":"php.png"],
        ["name":"JS", "key":"","pic":"js.png"],
        ["name":"React", "key":"","pic":"react.png"],
        ["name":"Ruby", "key":"","pic":"ruby.png"],
        ["name":"HTML", "key":"","pic":"html.png"],
        ["name":"C#", "key":"","pic":"c#.png"]
    ]
    
    func _createCollectionView() {
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
        layout.itemSize = CGSize(width:itemWidth, height:112)
        let frame = CGRect(x: 0, y: 300, width: ScreenWidth, height: 240)
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
        return cell;
        
    }
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index is \(indexPath.row)")
        let key: String = courses[indexPath.item]["key"]!
        switch key {
        case "scan":
            self.hidesBottomBarWhenPushed = true
            _push(view: self, target: ZHQRCodeViewController(), rootView: true)
        default:
            self.hidesBottomBarWhenPushed = true
            _push(view: self, target: GoodDetailViewController(), rootView: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
//        http://www.hangge.com/blog/cache/detail_957.html
        // 静态引导页
        //        self.setStaticGuidePage()
        
        // 动态引导页
        //         self.setDynamicGuidePage()
        
        // 视频引导页
//        self.setStaticGuidePage()
        
        // Do any additional setup after loading the view.
        // set bar
        setNavBarTitle(view: self, title: "纵横ERP", transparent: false)
        
        // set back btn
        let selector: Selector = #selector(actionGo)
//        setBackBtn(view: self, selector: selector, title: "我的", parent: false)
        
//        let leftBtn = UIBarButtonItem(title: "我的", style: .plain, target: self, action: selector)
//        self.navigationItem.leftBarButtonItem = leftBtn
        
        
        // 设置左侧按钮
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: selector)
        leftBarBtn.image = UIImage(named: "userinfo-icon")
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -20
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
        // back Bar
//        let backBtn = UIBarButtonItem(title: "首页", style: .plain, target: self, action: selector)
//        self.navigationItem.backBarButtonItem = backBtn
//        self.navigationItem.backBarButtonItem?.tintColor = Specs.color.white
        setNavBarBackBtn(view: self, title: "首页", selector: #selector(actionBack))
        
        //
//        functionalBlock.layer.borderWidth = Specs.border.width
//        functionalBlock.layer.borderColor = Specs.color.main.cgColor
        
//        let controller1 = ViewController()
//        let navigation = UINavigationController(rootViewController:controller1)
//        controller1.title = "123"
//        controller1.navigationController?.navigationBar.barTintColor = Specs.color.main
//        let navigationDic = [NSAttributedStringKey.font : UIColor.white.cgColor]
//        controller1.navigationController?.navigationBar.titleTextAttributes = navigationDic
//        let controller2 = UIViewController()
//        controller2.view.backgroundColor = UIColor.red
//        self.addChildViewController(navigation)
//        self.addChildViewController(controller2)
//        controller1.tabBarItem.title = "111"
//        controller2.tabBarItem.title = "222"
        
        // Set tabBar background color
//        self.tabBarController?.tabBar.barTintColor = Specs.color.main
        
        
        // set Values
        todayTotalAmount.text = "123456789"
        historyShipments.text = "123"
        todayShipments.text = "456"
        residueShipments.text = "789"
        
        _createCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 按钮圆形
        setUIButtonToCircle(button: pickingBtn)
        setUIButtonToCircle(button: scanSendGoodBtn)
        setUIButtonToCircle(button: allocatingBtn)
        setUIButtonToCircle(button: warehouseBtn)
        setUIButtonToCircle(button: takeStockBtn)
        setUIButtonToCircle(button: settingBtn)
        
        // Set View Underline
        setViewWidgetBottomLine(widget: todayBlock)
        setViewWidgetBottomLine(widget: functionalBlock)
        setViewWidgetBottomLine(widget: rankingBlock)
    }
    
    
    // MARK: - 静态图片引导页
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["guide00", "guide01", "guide02"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.navigationController?.view.addSubview(guideView)
    }
    // MARK: - 动态图片引导页
    func setDynamicGuidePage() {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.navigationController?.view.addSubview(guideView)
    }
    
    // MARK: - 视频引导页
    func setVideoGuidePage() {
        let urlStr = Bundle.main.path(forResource: "1.mp4", ofType: nil)
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = HHGuidePageHUD.init(videoURL:videoUrl, isHiddenSkipButton: false)
        self.navigationController?.view.addSubview(guideView)
    }
    
    @objc func actionGo() {
        if(checkLoginStatus()) {
            _push(view: self, target: MemberViewController())
//            _push(view: self, target: RegisteringViewController(), rootView: true)
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
    
    @objc func actionBack() {
        print("self.hidesBottomBarWhenPushed = false")
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if(checkLoginStatus()) {
//            _open(view: self, vcName: "home")
//        } else {
//            _open(view: self, vcName: "login", withNav: false)
//        }
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

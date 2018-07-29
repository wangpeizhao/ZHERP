//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
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
    }
    @IBAction func ScanSendGoodBtnClicked(_ sender: Any) {
    }
    @IBAction func AllocatingBtnClicked(_ sender: Any) {
    }
    @IBAction func WarehouseBtnClicked(_ sender: Any) {
    }
    @IBAction func TakeStockBtnClicked(_ sender: Any) {
    }
    @IBAction func SettingBtnClicked(_ sender: Any) {
    }
    
    var vc: UIViewController!
    var withNav: Bool!
    
    @IBOutlet weak var homeTxt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: BaseViewController{
    
    
    var reportView: HomeReportViewController?
    var chartsView: HomeChartsViewController?
    var navigationView: HomeNavigationViewController?
    
    var tableView: UITableView?
    
//
//
//
//
//
//
//    @IBOutlet weak var pickingBtn: UIButton!
//    @IBOutlet weak var scanSendGoodBtn: UIButton!
//    @IBOutlet weak var allocatingBtn: UIButton!
//    @IBOutlet weak var warehouseBtn: UIButton!
//    @IBOutlet weak var takeStockBtn: UIButton!
//    @IBOutlet weak var settingBtn: UIButton!
//    @IBOutlet weak var functionalBlock: UIView!
//    @IBOutlet weak var homeNavBar: UINavigationBar!
//    @IBOutlet weak var rankingBlock: UIView!
//    @IBOutlet weak var todayBlock: UIView!
//
//    @IBOutlet weak var todayTotalAmount: UILabel!
//    @IBOutlet weak var historyShipments: UILabel!
//    @IBOutlet weak var todayShipments: UILabel!
//    @IBOutlet weak var residueShipments: UILabel!
//    //    @IBOutlet weak var todayShipments: UILabel!
////    @IBOutlet weak var residueShipments: UILabel!
//
//
//    @IBAction func memberCenter(_ sender: Any) {
//        if(checkLoginStatus()) {
////            _push(view: self, target: MemberViewController(), rootView: true)
//            _push(view: self, target: RegisteringViewController(), rootView: true)
//        } else {
//            _open(view: self, vcName: "login", withNav: false)
//        }
//    }
//
//    @IBAction func PickingBtnClicked(_ sender: Any) {
//        self.hidesBottomBarWhenPushed = true
//        _push(view: self, target: OrderAllViewController(), rootView: true)
//    }
//    @IBAction func ScanSendGoodBtnClicked(_ sender: Any) {
//        self.hidesBottomBarWhenPushed = true
//        _push(view: self, target: ZHQRCodeViewController(), rootView: true)
//    }
//    @IBAction func AllocatingBtnClicked(_ sender: Any) {
//    }
//    @IBAction func WarehouseBtnClicked(_ sender: Any) {
//    }
//    @IBAction func TakeStockBtnClicked(_ sender: Any) {
//    }
//    @IBAction func SettingBtnClicked(_ sender: Any) {
//        self.hidesBottomBarWhenPushed = true
//        _push(view: self, target: GoodDetailViewController(), rootView: true)
//    }
//
//    var vc: UIViewController!
//    var withNav: Bool!
//
//    @IBOutlet weak var homeTxt: UIButton!
//
//
//
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        setNavBarTitle(view: self, title: "纵横ERP", transparent: false)
        setNavBarBackBtn(view: self, title: "首页", selector: #selector(actionBack))
        
        
        // set back btn
        let selector: Selector = #selector(actionGo)
        // 设置左侧按钮
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: selector)
        leftBarBtn.image = UIImage(named: "userinfo-icon")
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -30
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
//        navigationView = HomeNavigationViewController()
        
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        //去除单元格分隔线
        self.tableView!.separatorStyle = .singleLine
        //去除表格上放多余的空隙
//        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.view.addSubview(self.tableView!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 按钮圆形
//        setUIButtonToCircle(button: pickingBtn)
//        setUIButtonToCircle(button: scanSendGoodBtn)
//        setUIButtonToCircle(button: allocatingBtn)
//        setUIButtonToCircle(button: warehouseBtn)
//        setUIButtonToCircle(button: takeStockBtn)
//        setUIButtonToCircle(button: settingBtn)
        
        // Set View Underline
//        setViewWidgetBottomLine(widget: todayBlock)
//        setViewWidgetBottomLine(widget: functionalBlock)
//        setViewWidgetBottomLine(widget: rankingBlock)
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "搜索历史"
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 35
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        if (section == 0) {
            self.reportView = HomeReportViewController()
            return self.reportView?.view
        }
        if (section == 1) {
            self.chartsView = HomeChartsViewController()
            return self.chartsView?.view
        }
        if (section == 2) {
            self.navigationView = HomeNavigationViewController()
            return self.navigationView?.view
        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 150
        }
        if (section == 1) {
            return 80
        }
        if (section == 2) {
            return 240
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "长按可删除搜索历史记录"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //将分组尾设置为一个空的View
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        
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
//
//        let keyword: String? = self.items[indexPath.row]
//        self.searchController.searchBar.text = keyword
//    }
}

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
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navHeight = self.navigationController?.navigationBar.frame.size.height
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        self.view.backgroundColor = UIColor.clear
        setNavBarTitle(view: self, title: "纵横ERP", transparent: false)
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置左侧按钮
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionMemeber))
        leftBarBtn.image = UIImage(named: "userinfo-icon")
        leftBarBtn.tintColor = Specs.color.white

        self.navigationItem.leftBarButtonItems = [leftBarBtn]
        
        // 设置右侧按钮
        let rightBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtn.image = UIImage(named: "scan")
        rightBarBtn.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtn]
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)

        self.view.addSubview(self.tableView!)
        
    }
    
    @objc func actionMemeber() {
        if(checkLoginStatus()) {
            _push(view: self, target: MemberViewController())
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
    
    @objc func actionScan() {
        self.hidesBottomBarWhenPushed = true
        let _target = ZHQRCodeViewController()
        _target.actionType = "good"
        _target.navTitle = "扫码货品详情"
        _push(view: self, target: _target, rootView: true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    @objc func actionBack() {
        print("self.hidesBottomBarWhenPushed = false")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(!checkLoginStatus()) {
            _open(view: self, vcName: "login", withNav: false)
        }
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            self.reportView = HomeReportViewController()
            self.addChildViewController(self.reportView!)
            return self.reportView?.view
        }
//        if (section == 1) {
//            self.chartsView = HomeChartsViewController()
//            self.addChildViewController(self.chartsView!)
//            return self.chartsView?.view
//        }
        if (section == 1) {
            self.navigationView = HomeNavigationViewController()
            self.navigationView?._height = ScreenHeight - self.navHeight - 160 - self.tabBarHeight
            self.addChildViewController(self.navigationView!)
            return self.navigationView?.view
        }
//        if (section == 3) {
////            let chartsView = StatisticChartsViewController()
////            chartsView.ChartViewHeight = ScreenHeight - self.navHeight - 415 - self.tabBarHeight
////            self.addChildViewController(chartsView)
////            return chartsView.view
//            self.navigationView = HomeNavigationViewController()
//            self.addChildViewController(self.navigationView!)
//            return self.navigationView?.view
//        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 140
        }
        if (section == 1) {
//            return 70
            return ScreenHeight - self.navHeight - 140 - self.tabBarHeight
        }
//        if (section == 2) {
////            return 205
//            return ScreenHeight - self.navHeight - 210 - self.tabBarHeight
//        }
//        if (section == 3) {
//            return ScreenHeight - self.navHeight - 415 - self.tabBarHeight
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath)
        
        return cell
    }
}

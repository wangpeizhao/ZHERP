//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
//import Charts
import UserNotifications

class HomeViewController: BaseViewController{
    
    var reportView: HomeReportViewController?
    var chartsView: HomeChartsViewController?
    var navigationView: HomeNavigationViewController?
    
    var tableView: UITableView?
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    var notificationHandler: NotificationHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navHeight = self.navigationController?.navigationBar.frame.size.height
        self.navHeight = self.navigationController?.navigationBar.frame.maxY ?? 0.0
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height ?? 0.0
        
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
        
        
        self.notificationHandler = NotificationHandler(view: self)
        
        //请求通知权限
        self._requestAuthorization()
        
        // http://www.hangge.com/blog/cache/detail_2031.html
        // https://github.com/jdg/MBProgressHUD
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //纯文本模式
//        hud.mode = .text
        //设置提示标题
        hud.label.text = "请稍等"
        //设置提示详情
        hud.detailsLabel.text = "具体要等多久我也不知道"
        hud.removeFromSuperViewOnHide = true //隐藏时从父视图中移除
        hud.hide(animated: true, afterDelay: 5)  //2秒钟后自动隐藏
        
        // http://www.hangge.com/blog/cache/detail_2033.html
        // https://github.com/johnlui/SwiftNotice
        //方法1
//        SwiftNotice.showNoticeWithText(NoticeType.success, text:"操作成功", autoClear: true, autoClearTime: 3)
        //方法2
        self.noticeSuccess("操作成功", autoClear: true, autoClearTime: 3)
    }
    
    //请求通知权限
    fileprivate func _requestAuthorization() {
//        UNUserNotificationCenter.current()
//            .requestAuthorization(options: [.alert, .sound, .badge]) {
//                (accepted, error) in
//                if !accepted {
//                    print("用户不允许消息通知。")
//                }
//        }
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            switch settings.authorizationStatus {
            case .authorized:
                print("用户允许推送消息。")
                self._userNotifications()
                self._userNotificationsTiming()
                // 获取已提交的推送消息
                UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
                    //遍历所有已推送的通知
//                    for notification in notifications {
//                        print(notification)
//                    }
                }
                return
            case .notDetermined:
                print("需要用户选择允许与否。")
                //请求授权
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) {
                        (accepted, error) in
                        if !accepted {
                            print("用户拒绝了消息通知。")
                            DispatchQueue.main.async(execute: { () -> Void in
                                let alertController = UIAlertController(title: "消息推送已关闭",
                                                                        message: "想要及时获取最新消息。点击“设置”，开启通知。",
                                                                        preferredStyle: .alert)
                                
                                let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
                                
                                let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                                    (action) -> Void in
                                    let url = URL(string: UIApplicationOpenSettingsURLString)
                                    if let url = url, UIApplication.shared.canOpenURL(url) {
                                        if #available(iOS 10, *) {
                                            UIApplication.shared.open(url, options: [:],
                                                                      completionHandler: {
                                                                        (success) in
                                            })
                                        } else {
                                            UIApplication.shared.openURL(url)
                                        }
                                    }
                                })
                                
                                alertController.addAction(cancelAction)
                                alertController.addAction(settingsAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            })
                        }
                }
            case .denied:
                print("消息推送已关闭。")
            }
        }
        //设置通知代理
        UNUserNotificationCenter.current().delegate = self.notificationHandler
    }
    
    fileprivate func _userNotifications() {
        //设置推送内容
        let _content = UNMutableNotificationContent()
        _content.title = "纵横ERP最新消息"
        _content.body = "纵横ERP上线啦，欢迎使用"
        _content.badge = 3
        _content.subtitle = "上线通知"
        _content.userInfo = ["actionName": "MrParker", "articleId": 10086]
        
        //设置通知触发器
        let _trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //设置请求标识符
        let _requestIdentifier = "www.zhskills.com"
        
        //设置一个通知请求
        let _request = UNNotificationRequest(identifier: _requestIdentifier, content: _content, trigger: _trigger)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(_request, withCompletionHandler: {(error) -> Void in
            if error == nil {
                print("Time Single Notification scheduled: \(_requestIdentifier)")
            }
        })
    }
    
    fileprivate func _userNotificationsTiming() {
        //设置推送内容
        let _content = UNMutableNotificationContent()
        _content.title = "纵横ERP最新订单消息"
        _content.body = "纵横ERP刚出新订单啦"
        _content.badge = 4
        _content.subtitle = "订单通知"
        
        //设置通知触发器
        var components = DateComponents()
//        components.weekday = 4 //周4
        components.hour = 11 //上午10点
        components.minute = 40 //40分
        components.second = 10 //10秒
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        //设置请求标识符
        let _requestIdentifier = "www.zhskills.com.timing"
        
        //设置一个通知请求
        let _request = UNNotificationRequest(identifier: _requestIdentifier, content: _content, trigger: trigger)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(_request, withCompletionHandler: {(error) -> Void in
            if error == nil {
                print("Time Interval Notification scheduled: \(_requestIdentifier)")
            }
        })
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
        // 设置弹出提示框的底层视图控制器 代码初始化放在这 返回的时候才可改变通知
//        self._initNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    fileprivate func _initNotifications() {
//        let notiSetting = UIApplication.shared.currentUserNotificationSettings
//        if notiSetting?.types == UIUserNotificationType.init(rawValue: 0) {
//            print("_initNotifications true")
////            self.switchNoti.isOn = false
//        } else {
//            print("_initNotifications false")
////            self.switchNoti.isOn = true
////            self.switchNoti.isEnabled = false
//            
//            //打开APP系统设置页
//            let urlObj = URL(string:UIApplicationOpenSettingsURLString)
//            // 前往设置
//            UIApplication.shared.open(urlObj! as URL, options: [ : ]) { (result) in
//                // 如果判断是否返回成功
//                if result {
//                    
//                    let notiSetting = UIApplication.shared.currentUserNotificationSettings
//                    if notiSetting?.types == UIUserNotificationType.init(rawValue: 0) {
////                        self.switchNoti.isOn = false
////                        self.switchNoti.isEnabled = true
//                    } else {
////                        self.switchNoti.isOn = true
////                        self.switchNoti.isEnabled = false
//                    }
//                    
//                    
//                }
//            }
//        }
//    }

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
            self.navigationView?._height = ScreenHeight - self.navHeight - 220 - self.tabBarHeight
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
            return 200
        }
        if (section == 1) {
//            return 70
            return ScreenHeight - self.navHeight - 200 - self.tabBarHeight
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

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    var _view: UIViewController
    
    init(view: UIViewController) {
        self._view = view
    }
    
    //在应用内展示通知
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        
        // 如果不想显示某个通知，可以直接用空 options 调用 completionHandler:
        // completionHandler([])
    }
    
    //对通知进行响应（用户与通知进行交互时被调用）
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler:
        @escaping () -> Void) {
        print(response.notification.request.content.title)
        print(response.notification.request.content.body)
        //获取通知附加数据
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        let _value = userInfo[AnyHashable("actionName")] as! String
        if _value == "MrParker" {
            let _articleId = userInfo[AnyHashable("articleId")] as! Int
            print(_articleId)
            let _target = SProtocolViewController()
//            let _view = HomeViewController()
            _push(view: _view, target: _target)
        }
        //完成了工作
        completionHandler()
    }
}

//
//  StatisticViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        setNavBarTitle(view: self, title: "分析统计")
        setNavBarBackBtn(view: self, title: "分析统计", selector: #selector(actionBack))
        
//        setNavBarRightBtn(view: self, title: "经营分析", selector: #selector(actionBusiness))
        
        self._setUp()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionBusiness() {
        
    }
    
    fileprivate func _setUp() {
        self.navHeight = self.navigationController?.navigationBar.frame.size.height
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
//        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - self.tabBarHeight)
//        self.tableView = UITableView(frame: frame, style:.grouped)
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let reportView = StatisticReportViewController()
            self.addChildViewController(reportView)
            return reportView.view
        }
        if (section == 1) {
            let navigationView = StatisticNavigationViewController()
            self.addChildViewController(navigationView)
            return navigationView.view
        }
        if (section == 2) {
            let chartsView = StatisticChartsViewController()
            chartsView.ChartViewHeight = ScreenHeight - self.navHeight - 210 - 205 - self.tabBarHeight
            self.addChildViewController(chartsView)
            return chartsView.view
        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 210
        }
        if (section == 1) {
            return 205
        }
        if (section == 2) {
            return ScreenHeight - self.navHeight - 210 - 205 - self.tabBarHeight
        }
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

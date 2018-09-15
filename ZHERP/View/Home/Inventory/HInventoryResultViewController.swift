//
//  HInventoryResultViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/14.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HInventoryResultViewController: UIViewController {

    var navHeight: CGFloat!
    var gridViewController: UICollectionGridViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "盘点结果")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮(moreMenu)
        let rightBarBtnMoreMenu = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionMoreMenu))
        rightBarBtnMoreMenu.image = UIImage(named: "moreMenu")
        rightBarBtnMoreMenu.tintColor = Specs.color.white
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -20;
        
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [rightBarBtnMoreMenu, spacer]
//        self.navigationItem.rightBarButtonItems = [rightBarBtnMoreMenu]
        
        self._setUp()
    }
    
    fileprivate func _setUp() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        gridViewController = UICollectionGridViewController()
        gridViewController.setColumns(columns: ["编号","单位", "账面数量", "盘点数量", "盈亏数量"])
        gridViewController.addRow(row: ["No.01","hangge", "100", "8", "60%"])
        gridViewController.addRow(row: ["No.01","张三", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.01","李四", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.01","王五", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.01","韩梅梅", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.01","李雷", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.01","王大力", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.01","hangge", "100", "8", "60%"])
        gridViewController.addRow(row: ["No.02","张三", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.03","李四", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.04","王五", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.05","韩梅梅", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.06","李雷", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.07","王大力", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.08","蝙蝠侠", "100", "8", "60%"])
        gridViewController.addRow(row: ["No.09","超人", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.10","钢铁侠", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.11","灭霸", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.12","快银", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.13","闪电侠", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.14","绿箭", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.15","绿巨人", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.16","黑寡妇", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.17","企鹅人", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.18","双面人", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.19","奥特曼", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.20","小怪兽s", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.09","超人", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.10","钢铁侠", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.11","灭霸", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.12","快银", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.13","闪电侠", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.14","绿箭", "33", "22", "15%"])
        gridViewController.addRow(row: ["No.15","绿巨人", "223", "16", "81%"])
        gridViewController.addRow(row: ["No.16","黑寡妇", "143", "25", "93%"])
        gridViewController.addRow(row: ["No.17","企鹅人", "75", "2", "53%"])
        gridViewController.addRow(row: ["No.18","双面人", "43", "12", "33%"])
        gridViewController.addRow(row: ["No.19","奥特曼", "33", "27", "45%"])
        gridViewController.addRow(row: ["No.20","小怪兽s", "33", "22", "15%"])
        self.view.addSubview(gridViewController.view)
    }
    
    @objc func actionMoreMenu() {
        
    }
    
    @objc func actionBack() {
        
    }
    
    override func viewDidLayoutSubviews() {
        self.gridViewController.view.frame = CGRect(x:0, y: self.navHeight + 10, width: ScreenWidth ,height: ScreenHeight - self.navHeight - 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

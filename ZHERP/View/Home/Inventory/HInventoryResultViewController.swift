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
    
    var moreView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "盘点结果")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮(moreMenu)
        let rightBarBtnMoreMenu = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionMore))
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
        
        self._moreView()
        
        // 右上用下拉菜单 手势
        let tapMore = UITapGestureRecognizer(target: self, action: #selector(tapMore(_:)))
        tapMore.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapMore)
    }
    
    @objc func actionMore() {
        self.moreView.isHidden = !self.moreView.isHidden
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionMoreItem(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.actionItemSave()
        case 1:
            self.actionItemSave()
        case 2:
            self.actionItemSave()
        default:
            self.actionItemSave()
        }
        self.moreView.isHidden = true
    }
    @objc func tapMore(_ tapMore : UITapGestureRecognizer){
        self.moreView.isHidden = true
    }
    
    func actionItemSave() {
//        let frame = self.view.frame
        UIGraphicsBeginImageContext(CGSize(width: ScreenWidth, height: ScreenHeight + self.navHeight))
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(signature, self, #selector(actionItemSaveImage(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc private func actionItemSaveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var showMessage = ""
        if error != nil{
            showMessage = "保存失败"
        }else{
            showMessage = "保存成功"
        }
        _tip(view: self, title: showMessage)
    }
    
    // 右上角下拉菜单
    func _moreView() {
        self.moreView = UIView(frame: CGRect(x: ScreenWidth - 120, y: self.navHeight, width: 110, height: 145))
        self.moreView.isHidden = true
        let imgBgTop = UIImageView(frame: CGRect(x: self.moreView.frame.size.width - 35, y: 0, width: 20, height: 10))
        imgBgTop.image = UIImage(named: "jump_list_bg_top")
        self.moreView.addSubview(imgBgTop)
        //        self.moreView.addTarget(self, action:#selector(hideMoreMenu(_:)), for:.touchUpInside)
        
        let vBg = UIView(frame: CGRect(x: 2, y: imgBgTop.frame.size.height, width: self.moreView.frame.size.width, height: self.moreView.frame.size.height))
        vBg.backgroundColor = normalRGBA(r: 49, g: 58, b: 67, a: 1)
        vBg.layer.cornerRadius = 5.0
        vBg.layer.masksToBounds = true
        self.moreView.addSubview(vBg)
        
        let moreArr = ["发送邮件", "保存图片", "删除结果"]
        let _moreArrCount = moreArr.count
        if _moreArrCount > 0 {
            for index in 0..<_moreArrCount {
                let _moreBtn = UIButton(frame: CGRect(x: 0, y: 45 * index + 10, width: Int(self.moreView.frame.size.width), height: 45))
                _moreBtn.setTitle(moreArr[index], for: .normal)
                _moreBtn.setTitleColor(Specs.color.white, for: .normal)
                let _tag = index
                _moreBtn.tag = _tag
                _moreBtn.addTarget(self, action: #selector(actionMoreItem(_:)), for: .touchUpInside)
                _moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                self.moreView.addSubview(_moreBtn)
                
                let _height = _moreBtn.frame.origin.y
                //                print((_height + 5) * CGFloat(index + 1))
                // 分割线
                if index < _moreArrCount - 1 {
                    let _sigline = UIImageView(frame: CGRect(x: 0, y: (_height + 40), width: _moreBtn.frame.size.width, height: 11))
                    _sigline.image = UIImage(named: "line1")
                    self.moreView.addSubview(_sigline)
                }
            }
        }
        self.view.addSubview(self.moreView)
    }
    
    override func viewDidLayoutSubviews() {
        self.gridViewController.view.frame = CGRect(x:0, y: self.navHeight + 10, width: ScreenWidth ,height: ScreenHeight - self.navHeight - 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  HPickingCompleteViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HPickingCompleteViewController: UIViewController {

    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    // 初始数据
    var valueArr = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "拣货商品")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮
        let rightBarBtnRefresh = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionRefresh))
        rightBarBtnRefresh.image = UIImage(named: "refresh")
        rightBarBtnRefresh.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnRefresh]
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionRefresh() {
        
    }
    
    @objc func actionSubmitAdd() {
        
    }
    
    fileprivate func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        self._setTabBarCart()
    }
    
    fileprivate func _setTabBarCart() {
        // tabBarView
        let _tabBarView = UIView()
        _tabBarView.backgroundColor = Specs.color.white
        self.view.addSubview(_tabBarView)
        _tabBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth)
        }
        
        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = Specs.color.gray
        _tabBarView.addSubview(_separator)
        _separator.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_tabBarView.snp.top)
            make.left.right.equalTo(0)
            make.width.equalTo(_tabBarView.snp.width)
            make.height.equalTo(1)
        }
        
        // Btn
        let _btn = UIButton()
        _btn.layer.masksToBounds = true
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.setTitle("添加", for: .normal)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.addTarget(self, action: #selector(actionSubmitAdd), for: .touchUpInside)
        _tabBarView.addSubview(_btn)
        _btn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.width.equalTo(ScreenWidth - 40)
            make.height.equalTo(40)
            make.center.equalTo(_tabBarView)
        }
        
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

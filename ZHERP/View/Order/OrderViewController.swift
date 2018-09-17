//
//  OrderViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit
import BTNavigationDropdownMenu

class OrderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var _title: String = "订单管理"
    var _placeholder: String = "搜索订单号"
    var pageMenuView: UIView!
    var orderPageMenuView: OrderPagingMenuViewController?
    //下拉菜单
    var menuView: BTNavigationDropdownMenu!
    
    var navHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        
        setNavBarBackBtn(view: self, title: self._title, selector: #selector(actionBack))
        setNavBarRightBtn(view: self, title: "发货", selector: #selector(actionDelivery))
        
        self._setUp()
    }
    
    private func _setUp() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        self._navigationDropdownMenus()
        self._searchBarBtn()
        
        self.pageMenuView = UIView(frame: CGRect(x: 0, y: self.navHeight + 50, width: ScreenWidth, height: ScreenHeight - self.navHeight + 50))
        self.view.addSubview(self.pageMenuView)
        
        self.orderPageMenuView = OrderPagingMenuViewController()
        self.addChildViewController(self.orderPageMenuView!)
        self.pageMenuView.addSubview((self.orderPageMenuView?.view)!)
    }
    
    func _searchBarBtn() {
        let frame = self.view.frame.size
        let buttonView = UIView(frame: CGRect(x: 0, y: self.navHeight!, width: frame.width, height: 50))
        buttonView.backgroundColor = UIColor(hex: 0xefeef4)
        self.view.addSubview(buttonView)
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: 30))
        button.setTitle(self._placeholder, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(hex: 0x8e8e93), for: UIControlState())
        button.backgroundColor = Specs.color.white
        button.layer.borderWidth = 0;
        button.layer.borderColor = UIColor(hex: 0xf5f5f5).cgColor
        button.layer.cornerRadius = Specs.border.radius
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goSearch), for: .touchUpInside)
        buttonView.addSubview(button)
    }
    
    @objc func goSearch() {
        let _view = SearchViewController()
        _view.navBarTitle = self._title
        _view.searchBarPlaceholder = self._placeholder
        _view.searchType = "order"
        _push(view: self, target: _view)
    }
    
    @objc func actionBack() {
//        _push(view: self, target: OrderDetailViewController())
    }
    
    @objc func actionDelivery() {
        let _target = HDeliverViewController()
        _push(view: self, target: _target)
    }
    
    private func _navigationDropdownMenus() {
        //导航栏背景色（下拉菜单栏也用同样的颜色）
        self.navigationController?.navigationBar.barTintColor = Specs.color.main
        //导航栏文字使用白色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)]
        //下拉菜单项
        let items = ["线上订单", "线下订单"]
        
        //创建下拉菜单
        menuView = BTNavigationDropdownMenu(
            navigationController: self.navigationController,
            containerView: self.navigationController!.view,
            title: "订单类型", items: items
        )
        //单元格文字颜色
        menuView.cellTextLabelColor = Specs.color.white
        //单元格背景色
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        //选中项背景色
        menuView.cellSelectionColor = UIColor(hex: 0x0c6bbb)
        //保持选中项的颜色
        menuView.shouldKeepSelectedCellColor = true
        
        //下拉菜单项选中事件响应
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("当前点击项的索引: \(indexPath)")
        }
        
        //将下拉菜单设置为titleView
        self.navigationItem.titleView = menuView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

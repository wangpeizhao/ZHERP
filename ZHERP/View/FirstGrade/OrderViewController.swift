//
//  OrderViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import SnapKit
import PagingMenuController

class OrderViewController: UIViewController {
    
    var searchBarView: UIView!
    var pageMenuView: UIView!

    //下拉菜单
    var menuView: BTNavigationDropdownMenu!
    
    // Search
    var searchController = UISearchController()
    
    var contentLabel: UILabel!
    
    let currentVersion = getIOSVersion()
    
    var searchWord: UILabel!
    
    var accessoryView: UIView!
    
    var searchBarHeightConstraint: Constraint?
    
    //搜索框图片加上图片和字体之间的距离
    var searchOffset: CGFloat = 0
    
    var searchHeight: CGFloat = 35

    var navHeight: CGFloat!
    
    var keyboardHeight: CGFloat = 0
    
    var viewHeight: CGFloat!
    
    var searchProv: UIView!
    var searchHistoryView: UIView!
    var searchResultView: UIView!
    
    
    //分页菜单配置
    private struct PagingMenuOptions: PagingMenuControllerCustomizable {
        
        //默认显示第2页
        var defaultPage: Int = 0
        
        //页面切换动画播放时间为0.5秒
        var animationDuration: TimeInterval = 0.5
        
        //不允许手指左右滑动页面切换
        var isScrollEnabled: Bool = true
        
        //页面背景色为紫色
        var backgroundColor: UIColor = .white
        
        //lazy loading的页面数量（默认值就是.three）
        var lazyLoadingPage: LazyLoadingPage = .all
        
        //不太清楚干嘛用的（默认值就是.multiple）
        var menuControllerSet: MenuControllerSet = .multiple
        
        
        var height: CGFloat = 20
        //选中项为橙色下划线样式
        var focusMode: MenuFocusMode = .underline(height: 1, color: .orange, horizontalPadding: 0, verticalPadding: 0)
        
        //Order All 子视图控制器
        private let orderAllView = OrderAllViewController()
        //Order Pay 子视图控制器
        private let orderPayView = OrderPayViewController()
        //Order Unpay 子视图控制器
        private let orderUnpayView = OrderUnpayViewController()
        //Order Close 子视图控制器
        private let orderCloseView = OrderCloseViewController()
        //Order All 子视图控制器
        private let orderCompleteView = OrderCompleteViewController()
        
        //组件类型
        fileprivate var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
        }
        
        //所有子视图控制器
        fileprivate var pagingControllers: [UIViewController] {
            return [orderAllView, orderPayView, orderUnpayView, orderCloseView, orderCompleteView]
        }
        
        //菜单配置项
        fileprivate struct MenuOptions: MenuViewCustomizable {
            //菜单显示模式
            var displayMode: MenuDisplayMode {
//                return .segmentedControl
                return .infinite(widthMode: .flexible, scrollingMode: .pagingEnabled)
            }
            //菜单项
            var itemsOptions: [MenuItemViewCustomizable] {
                return [
                    MenuItemOrderAll(),
                    MenuItemOrderPay(),
                    MenuItemOrderUnPay(),
                    MenuItemOrderClose(),
                    MenuItemOrderComplete()
                ]
            }
        }
        
        //第1个菜单项
        fileprivate struct MenuItemOrderAll: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
//                return .text(title: MenuItemText(text: "全部", color: .lightGray, selectedColor: .orange, font: UIFont.systemFont(ofSize: 14), selectedFont: UIFont.systemFont(ofSize: 14)))
                return .text(title: MenuItemText(text: "全部"))
            }
        }
        
        //第2个菜单项
        fileprivate struct MenuItemOrderPay: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "已支付"))
            }
        }
        
        //第3个菜单项
        fileprivate struct MenuItemOrderUnPay: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "未支付"))
            }
        }
        
        //第4个菜单项
        fileprivate struct MenuItemOrderClose: MenuItemViewCustomizable {
            //该标签的水平边距设为50
//            var horizontalMargin: CGFloat = 5
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "已关闭"))
            }
        }
        
        //第5个菜单项
        fileprivate struct MenuItemOrderComplete: MenuItemViewCustomizable {
            //该标签的水平边距设为50
//            var horizontalMargin: CGFloat = 5
//            var height: CGFloat = 20
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "已完成"))
//                let menuCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//                menuCustomView.layer.backgroundColor = UIColor.gray.cgColor
//                let menuTitle = UILabel()
//                menuTitle.text = "已完成"
//                menuTitle.font = UIFont.systemFont(ofSize: 13)
//                let menuImage = UIImageView()
//                menuImage.image = UIImage(named: "VoiceSearchStartBtn")
//                menuCustomView.addSubview(menuTitle)
//                menuTitle.snp.makeConstraints { (make) -> Void in
//                    make.left.equalTo(5)
//                    make.centerY.equalTo(menuCustomView)
//                }
//                menuCustomView.addSubview(menuImage)
//                menuImage.snp.makeConstraints { (make) -> Void in
//                    make.right.equalTo(5)
//                    make.left.equalTo(menuTitle.snp.right).offset(3)
//                    make.centerY.equalTo(menuCustomView)
//                }
//                return .custom(view: menuCustomView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.grayBg
        viewHeight = self.view.frame.height
        //注册监听
        
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        self.searchBarView = UIView()
        self.searchBarView.layer.backgroundColor = Specs.color.white.cgColor
        self.view.addSubview(self.searchBarView)
        self.searchBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.navHeight)
            make.height.equalTo(searchHeight)
        }
        
        self.pageMenuView = UIView()
        self.pageMenuView.layer.backgroundColor = Specs.color.white.cgColor
        self.view.addSubview(self.pageMenuView)
        self.pageMenuView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.searchBarView.snp.bottom).offset(8)
            make.bottom.equalTo(self.view)
        }
        
        self.contentLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        self.view.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        
        self.setUp()
    }
    
    //MARK: 当键盘显示时
    @objc func handleKeyboardDisShow(notification: NSNotification) {
        print(self.view.frame)
        //得到键盘frame
    }
    
    func navigationDropdownMenus() {
        //导航栏背景色（下拉菜单栏也用同样的颜色）
        self.navigationController?.navigationBar.barTintColor = Specs.color.main
        //导航栏文字使用白色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)]
        
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
            self.contentLabel.text = items[indexPath]
        }
        
        //将下拉菜单设置为titleView
        self.navigationItem.titleView = menuView
    }
    
    func pagingMenus() {
        //分页菜单配置
        let options = PagingMenuOptions()
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        self.pageMenuView.addSubview(pagingMenuController.view)
        
        
        //页面切换响应
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签将要切换 ---")
//                print("老标签：\(previousMenuItemView.titleLabel.text!)")
//                print("新标签：\(menuItemView.titleLabel.text!)")
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签切换完毕 ---")
//                print("老标签：\(previousMenuItemView.titleLabel.text!)")
//                print("新标签：\(menuItemView.titleLabel.text!)")
            case let .willMoveController(menuController, previousMenuController):
                print("--- 页面将要切换 ---")
                print("老页面：\(previousMenuController)")
                print("新页面：\(menuController)")
            case let .didMoveController(menuController, previousMenuController):
                print("--- 页面切换完毕 ---")
                print("老页面：\(previousMenuController)")
                print("新页面：\(menuController)")
            case .didScrollStart:
                print("--- 分页开始左右滑动 ---")
            case .didScrollEnd:
                print("--- 分页停止左右滑动 ---")
            }
        }
        //自动将分页菜单控制器切换到第 2 个页面
//        pagingMenuController.move(toPage: 1, animated: true)
    }
    
    func searchBar() {
        self.searchController = UISearchController.buildSearchBar(_view: self, searchHeight: &searchHeight, searchOffset: &searchOffset, placeholder: " 搜索订单号")
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        
        //将搜索栏添加到页面上
        self.searchBarView.addSubview(searchController.searchBar)
        self.definesPresentationContext = true
    }
    @objc func _keyword() {
        searchWord.text = "Hello World!"
        searchController.searchBar.text = "Hello World!"
    }
    
    @objc func viewTapped(tap: UITapGestureRecognizer) {
        searchController.searchBar.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //移除监听
        NotificationCenter.default.removeObserver(self)
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

extension OrderViewController {
    func setUp() {
        navigationDropdownMenus()
        
        searchBar()

        pagingMenus()
    }
}
extension OrderViewController: UISearchBarDelegate {
    // 点击取消按钮
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.setPositionAdjustment(UIOffsetMake(searchOffset , 0), for: UISearchBarIcon.search)
        //重做约束
        self.searchBarView.snp.remakeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.navHeight - 10)
            make.height.equalTo(searchHeight + 1)
        }
        
        if let window = UIApplication.shared.keyWindow{
            window.viewWithTag(100)?.removeFromSuperview()
        }
    }
    
    // 输入时需要进行的操作
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.searchWord.text = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if currentVersion >= 11 {
            self.searchController.searchBar.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
        }
        
        self.searchBarView.snp.remakeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.navHeight)
            make.height.equalTo(searchHeight)
        }
        self.searchProv = UIView()
//        self.searchProv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5) //Specs.color.grayBg.cgColor.alpha(0.8)
        self.searchProv.backgroundColor = Specs.color.grayBg
        self.searchProv.tag = 100
        self.view.addSubview(self.searchProv)
        self.searchProv.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.navHeight).offset(-5)
            make.height.equalTo(self.view.frame.size.height - self.navHeight + 20)
        }
        
        self.searchHistoryView = UIView()
        self.searchHistoryView.backgroundColor = Specs.color.white
        self.searchProv.addSubview(self.searchHistoryView)
        self.searchHistoryView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.searchBarView.snp.bottom).offset(-58)
            make.height.equalTo(self.view.frame.size.height - self.navHeight + 20)
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if currentVersion >= 11 {
//            searchBar.setPositionAdjustment(UIOffsetMake(searchOffset / 2 , 0), for: UISearchBarIcon.search)
        }
        return true
    }
    
    // 输入完成时，点击按钮需要进行的操作
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.resignFirstResponder()
    }
}

extension OrderViewController: UISearchResultsUpdating{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        print(self.searchController.searchBar.text!)
    }
}

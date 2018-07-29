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
    
    
    //分页菜单配置
    private struct PagingMenuOptions: PagingMenuControllerCustomizable {
        
        //默认显示第2页
        var defaultPage: Int = 1
        
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
        var focusMode: MenuFocusMode = .underline(height: 1, color: .blue, horizontalPadding: 0, verticalPadding: 0)
//        public enum MenuItemDisplayMode {
//            case text(title: MenuItemText)  //普通标题文本
//            case multilineText(title: MenuItemText, description: MenuItemText)  //标题+描述文本
//            case image(image: UIImage, selectedImage: UIImage?)  //图片
//            case custom(view: UIView)  //自定义视图
//        }
        
        
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
                return .text(title: MenuItemText(text: "全部全部全部全部全部全部", color: .lightGray, selectedColor: .orange, font: UIFont.systemFont(ofSize: 13), selectedFont: UIFont.systemFont(ofSize: 18)))
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
            var horizontalMargin: CGFloat = 50
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "已关闭"))
            }
        }
        
        //第5个菜单项
        fileprivate struct MenuItemOrderComplete: MenuItemViewCustomizable {
            //该标签的水平边距设为50
            var horizontalMargin: CGFloat = 30
            var height: CGFloat = 20
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
//                return .text(title: MenuItemText(text: "已完成"))
                let menuCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
                menuCustomView.layer.backgroundColor = UIColor.gray.cgColor
                let menuTitle = UILabel()
                menuTitle.text = "已完成"
                menuTitle.font = UIFont.systemFont(ofSize: 13)
                let menuImage = UIImageView()
                menuImage.image = UIImage(named: "VoiceSearchStartBtn")
                menuCustomView.addSubview(menuTitle)
                menuTitle.snp.makeConstraints { (make) -> Void in
                    make.left.equalTo(5)
                    make.centerY.equalTo(menuCustomView)
                }
                menuCustomView.addSubview(menuImage)
                menuImage.snp.makeConstraints { (make) -> Void in
                    make.right.equalTo(5)
                    make.left.equalTo(menuTitle.snp.right).offset(3)
                    make.centerY.equalTo(menuCustomView)
                }
                return .custom(view: menuCustomView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBarView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        self.searchBarView.layer.backgroundColor = UIColor.gray.cgColor
        self.view.addSubview(self.searchBarView)
        self.searchBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(100)
            make.height.equalTo(150)
        }
        self.pageMenuView = UIView(frame: CGRect(x: 0, y: 50, width: 300, height: 500))
        self.pageMenuView.layer.backgroundColor = UIColor.brown.cgColor
        self.view.addSubview(self.pageMenuView)
        self.pageMenuView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(170)
            make.bottom.equalTo(self.view)
        }
        
        // Do any additional setup after loading the view.
        
        self.contentLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 50))
        self.view.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        
        self.setUp()
    }
    
    func navigationDropdownMenus() {
        //导航栏不透明
//        self.navigationController?.navigationBar.isTranslucent = false
        //导航栏背景色（下拉菜单栏也用同样的颜色）
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        //导航栏文字使用白色
        //        self.navigationController?.navigationBar.titleTextAttributes =
        //            [NSAttributedStringKey.font: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)]
        
        //下拉菜单项
        let items = ["中华料理", "西餐面点", "东南亚菜", "韩国泡菜"]
        
        //创建下拉菜单
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController,
                                            containerView: self.navigationController!.view,
                                            title: "美食", items: items)
        //单元格文字颜色
        menuView.cellTextLabelColor = UIColor.white
        //单元格背景色
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        //选中项背景色
        menuView.cellSelectionColor = UIColor(red: 0xff/255, green: 0xca/255,
                                              blue: 0x00/255, alpha: 1)
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
//        view.addSubview(pagingMenuController.view)
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
        //配置搜索控制器
        let space = 50;//搜索框图片加上图片和字体之间的距离
        
        
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
//            controller.delegate = self as? UISearchControllerDelegate
            controller.searchBar.delegate = self
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
//            controller.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 20, vertical: 0)
            controller.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//            controller.searchBar.searchFieldBackgroundPositionAdjustment = UIOffset(horizontal: 20, vertical: 0)
//            controller.searchBar.setScopeBarButtonTitleTextAttributes(<#T##attributes: [String : Any]?##[String : Any]?#>, for: <#T##UIControlState#>)
//            controller.searchBar.setImage(UIImage(named: "VoiceSearchStartBtn"), for: .search, state: UIControlState.normal)
            
            controller.searchBar.layer.masksToBounds = true;
            controller.searchBar.layer.cornerRadius = 4;
            controller.searchBar.layer.borderWidth = 1;
            controller.searchBar.contentMode = .center;
            controller.searchBar.layer.borderColor = UIColor.init(red: 197/255.0, green: 199/255.0, blue: 200/255.0, alpha: 1).cgColor;
            //        searchBar弹出的键盘类型设置
            controller.searchBar.returnKeyType = UIReturnKeyType.done;
            //        searchBar中的textField设置
            let searchField = controller.searchBar.value(forKey: "_searchField") as! UITextField;
            searchField.setValue(UIFont.systemFont(ofSize: 13), forKeyPath: "_placeholderLabel.font");
            searchField.setValue(UIColor.init(red: 70/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1), forKeyPath: "_placeholderLabel.textColor");
            
            //        判断是不是大于IOS 11
            if currentVersion < 11 {
                searchField.attributedPlaceholder = NSAttributedString.init(string: "SEARCH", attributes: [NSAttributedStringKey.baselineOffset:-2]);
            }else
            {
                //            searchBar中textField的placeholder的宽度可以获取
                //            let label = UILabel.init()
                //            label.text = "SEARCH"
                //            label.font = UIFont.systemFont(ofSize: 10)
                //            label.sizeToFit()
                //            print(label.frame.width)
                //            获取当前屏幕宽度
                self.view.frame.size.width = UIScreen.main.bounds.size.width
                //            重新布局
                self.view.layoutSubviews()
                //            计算偏移量:偏移量 =（searchBar的宽度-label宽度-搜索框图片加上图片和字体之间的宽度）/ 2
                controller.searchBar.setPositionAdjustment(UIOffsetMake((controller.searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
            }
            //        使键盘点击空白处关闭
//            let tap = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped(tap:)));
//            tap.cancelsTouchesInView = false;
//            self.view.addGestureRecognizer(tap);
            
            let accessoryView = UIView(frame: CGRect(x: 0, y: 84, width: self.view.frame.width, height: self.view.frame.height - 84))
            accessoryView.backgroundColor = UIColor.gray
            
            
            let historyTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            historyTitle.text = "搜索历史"
            accessoryView.addSubview(historyTitle)
            
            
            searchWord = UILabel(frame: CGRect(x: 0, y: 30, width: 200, height: 30))
//            historyTitle.text = "搜索历史"
            accessoryView.addSubview(searchWord)
            
            
            let keyword = UIButton(frame: CGRect(x: 0, y: 60, width: 200, height: 30))
            keyword.setTitle("Hello world", for: UIControlState.normal)
            keyword.addTarget(self, action: #selector(_keyword), for: UIControlEvents.touchUpInside)
            accessoryView.addSubview(keyword)
//
//            let historyList = ViewController()
//            accessoryView.addSubview(historyList.view)
            controller.searchBar.inputAccessoryView = accessoryView
            
            return controller
        })()
        
        //将搜索栏添加到页面上
        let searchBarFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        let searchBarContainer = UIView(frame: searchBarFrame)
        searchBarContainer.addSubview(searchController.searchBar)
//        self.view.addSubview(searchBarContainer)
        self.searchBarView.addSubview(searchBarContainer)
        
        //搜索栏取消按钮文字
        searchController.searchBar.setValue("取消", forKey:"_cancelButtonText")
        print(currentVersion)
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
    //点击搜索按钮
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        self.searchArray = self.schoolArray.filter { (school) -> Bool in
////            return school.contains(searchBar.text!)
////        }
//        print(searchBar.text!)
//    }
//    
//    //点击取消按钮
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.searchArray = self.schoolArray
        print("searchBarCancelButtonClicked")
        searchController.searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        输入时需要进行的操作
//        print(searchBar.text!)
//        print(searchText)
        self.searchWord.text = searchText
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing........................")
        if currentVersion >= 11 {
            
            searchController.searchBar.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
        }
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldEndEditing........................")
        if currentVersion >= 11 {
            
//            searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        输入完成时，点击按钮需要进行的操作
        print("searchBarSearchButtonClicked........................")
        searchBar.resignFirstResponder()
    }
}

extension OrderViewController: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
//        self.searchArray = self.schoolArray.filter { (school) -> Bool in
//            return school.contains(searchController.searchBar.text!)
//        }
        print(searchController.searchBar.text!)
        print("searchBarSearchUISearchResultsUpdatingButtonClicked........................")
    }
}

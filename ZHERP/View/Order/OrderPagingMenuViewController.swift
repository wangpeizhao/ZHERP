//
//  OrderPagingMenuViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/22.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import PagingMenuController

class OrderPagingMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    private func _setup() {
        self._pagingMenus()
    }
    
    //分页菜单配置
    private struct _pagingMenuOptions: PagingMenuControllerCustomizable {
        
        //默认显示第2页
        var defaultPage: Int = 0
        
        //页面切换动画播放时间为0.5秒
        var animationDuration: TimeInterval = 0.5
        
        //不允许手指左右滑动页面切换
        var isScrollEnabled: Bool = true
        
        //页面背景色为紫色
        var backgroundColor: UIColor = .white
        
        //lazy loading的页面数量（默认值就是.three）
        //        var lazyLoadingPage: LazyLoadingPage = .all
        
        //不太清楚干嘛用的（默认值就是.multiple）
        var menuControllerSet: MenuControllerSet = .multiple
        
        
        var height: CGFloat = 35
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
    
    private func _pagingMenus() {
        //分页菜单配置
        let options = _pagingMenuOptions()
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        self.view.addSubview(pagingMenuController.view)
        
        
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

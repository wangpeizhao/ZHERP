//
//  OrderBillsPagesViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import PagingMenuController

class OrderBillsPagesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    private func _setup() {
        self._pagingMenus()
    }
    
    func _MenuItemDisplayModeText(title: String) -> MenuItemDisplayMode{
        return .text(title: MenuItemText(text: title,font: UIFont.systemFont(ofSize: Specs.fontSize.regular)))
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
        // var lazyLoadingPage: LazyLoadingPage = .all
        
        //不太清楚干嘛用的（默认值就是.multiple）
        var menuControllerSet: MenuControllerSet = .multiple
        
        
        //选中项无样式
        var focusMode: MenuFocusMode = .none
        
        //Order All 子视图控制器
        private let orderAllView = BillsTodayViewController()
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
                return .infinite(widthMode: .flexible, scrollingMode: .pagingEnabled)
            }
            //设置菜单标签高度为40
            var height: CGFloat = 40
            //选中项为橙色下划线样式
            var focusMode: MenuFocusMode = .underline(height: 1, color: .orange, horizontalPadding: 0, verticalPadding: 0)
            //菜单项
            var itemsOptions: [MenuItemViewCustomizable] {
                return [
                    MenuItemOrderAll(),
                    MenuItemOrderPay(),
                    MenuItemOrderUnPay(),
                    MenuItemOrderClose(),
                    MenuItemOrderComplete(),
//                    MenuItemOrderLastMonth()
                ]
            }
        }
        
        //第1个菜单项
        fileprivate struct MenuItemOrderAll: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(
                    text: "今日",
                    color: UIColor(hex: 0x727272),
                    selectedColor: .orange,
                    font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
                    selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
                ))
            }
        }
        
        //第2个菜单项
        fileprivate struct MenuItemOrderPay: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "昨日",
                    color: UIColor(hex: 0x727272),
                    selectedColor: .orange,
                    font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
                    selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
                ))
            }
        }
        
        //第3个菜单项
        fileprivate struct MenuItemOrderUnPay: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "本周",
                    color: UIColor(hex: 0x727272),
                    selectedColor: .orange,
                    font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
                    selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
                ))
            }
        }
        
        //第4个菜单项
        fileprivate struct MenuItemOrderClose: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "近7天",
                    color: UIColor(hex: 0x727272),
                    selectedColor: .orange,
                    font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
                    selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
                ))
            }
        }
        
        //第5个菜单项
        fileprivate struct MenuItemOrderComplete: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "本月",
                    color: UIColor(hex: 0x727272),
                    selectedColor: .orange,
                    font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
                    selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
                ))
            }
        }
//        
//        //第6个菜单项
//        fileprivate struct MenuItemOrderLastMonth: MenuItemViewCustomizable {
//            //自定义菜单项名称
//            var displayMode: MenuItemDisplayMode {
//                return .text(title: MenuItemText(text: "上月",
//                                                 color: UIColor(hex: 0x727272),
//                                                 selectedColor: .orange,
//                                                 font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
//                                                 selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
//                ))
//            }
//        }
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

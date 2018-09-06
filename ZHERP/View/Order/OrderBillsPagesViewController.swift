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
        
        //默认显示第1页
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
        
        //今日 子视图控制器
        private let BillsToday = BillsTodayViewController()
        //昨天 子视图控制器
        private let BillsYesterday = BillsYesterdayViewController()
        //本周 子视图控制器
        private let BillsWeek = BillsWeekViewController()
        //近七天 子视图控制器
        private let BillsSevenDays = BillsSevenDaysViewController()
        //本月 子视图控制器
        private let BillsMonth = BillsMonthViewController()
        //上月 子视图控制器
        private let BillsLastMonth = BillsLastMonthViewController()
        
        //组件类型
        fileprivate var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
        }
        
        //所有子视图控制器
        fileprivate var pagingControllers: [UIViewController] {
            return [BillsToday, BillsYesterday, BillsWeek, BillsSevenDays, BillsMonth, BillsLastMonth]
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
                    MenuItemBillsToday(),
                    MenuItemBillsYesterday(),
                    MenuItemBillsWeek(),
                    MenuItemBillsSevenDays(),
                    MenuItemBillsMonth(),
                    MenuItemBillsLastMonth(),
                ]
            }
        }
        
        //第1个菜单项
        fileprivate struct MenuItemBillsToday: MenuItemViewCustomizable {
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
        fileprivate struct MenuItemBillsYesterday: MenuItemViewCustomizable {
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
        fileprivate struct MenuItemBillsWeek: MenuItemViewCustomizable {
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
        fileprivate struct MenuItemBillsSevenDays: MenuItemViewCustomizable {
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
        fileprivate struct MenuItemBillsMonth: MenuItemViewCustomizable {
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
        
        //第6个菜单项
        fileprivate struct MenuItemBillsLastMonth: MenuItemViewCustomizable {
            //自定义菜单项名称
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "上月",
                    color: UIColor(hex: 0x727272),
                    selectedColor: .orange,
                    font: UIFont.systemFont(ofSize: Specs.fontSize.regular),
                    selectedFont: UIFont.systemFont(ofSize: Specs.fontSize.regular)
                ))
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

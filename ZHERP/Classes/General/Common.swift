//
//  Common.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
// tabBar高度
let kTabBarH: CGFloat = 49.0

// 选择列表的cell高度
let SelectCellHeight: CGFloat = 44.0

var GlobalNavHeight: CGFloat = 44.0
var GlobalTabBarHeight: CGFloat = 44.0

// 全局分隔符
let globalSeparator: String = "*Z*H*E*R*P*"

// [Todo 暂没更好的处理方案]订单页面切换tabBar显示隐藏问题
var globalViewControllerForHiddenTabBar: UIViewController!

// MARK:- 颜色方法
func normalRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r, green: g, blue: b, alpha: a)
}

// MARK:- 常用按钮颜色
let kBtnWhite = RGBA(r: 0.97, g: 0.97, b: 0.97, a: 1.00)
let kBtnDisabledWhite = RGBA(r: 0.97, g: 0.97, b: 0.97, a: 0.30)
let kBtnGreen = RGBA(r: 0.15, g: 0.67, b: 0.16, a: 1.00)
let kBtnDisabledGreen = RGBA(r: 0.65, g: 0.87, b: 0.65, a: 1.00)
let kBtnRed = RGBA(r: 0.89, g: 0.27, b: 0.27, a: 1.00)
// 分割线颜色
let kSplitLineColor = RGBA(r: 0.78, g: 0.78, b: 0.80, a: 1.00)
// 常规背景颜色
let kCommonBgColor = RGBA(r: 0.92, g: 0.92, b: 0.92, a: 1.00)
let kSectionColor = RGBA(r: 0.94, g: 0.94, b: 0.96, a: 1.00)
// 导航栏背景颜色
let kNavBarBgColor = normalRGBA(r: 20, g: 20, b: 20, a: 0.9)

// 表情键盘颜色大全
let kChatBoxColor = normalRGBA(r: 244.0, g: 244.0, b: 246.0, a: 1.0)
let kLineGrayColor = normalRGBA(r: 188.0, g: 188.0, b: 188.0, a: 0.6)


// MARK:- 自定义打印方法
func LXFLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):(\(lineNum))-\(message)")
    
    #endif
}

func dateFromString(_ date: String, format: String = "yyyy-MM-dd") -> Date? {
    let dateForMatter = DateFormatter()
    dateForMatter.dateFormat = format
    return dateForMatter.date(from: date)
}

func stringFromDate(_ date: Date, format: String = "yyyy-MM-dd") -> String? {
    let dateForMatter = DateFormatter()
    dateForMatter.dateFormat = format
    return dateForMatter.string(from: date)
}

func system_datetime(format: String) -> String{
    let date = NSDate()
    
    let timeFormatter = DateFormatter()
    
    timeFormatter.dateFormat = format.isEmpty ? "yyyy-MM-dd HH:mm:ss" : format
    
    let strNowTime = timeFormatter.string(from: date as Date) as String
    
    return strNowTime
}

let SYSTEM_DATETIME = system_datetime(format: "yyyy-MM-dd HH:mm:ss")
let SYSTEM_DATE = system_datetime(format: "yyyy-MM-dd")

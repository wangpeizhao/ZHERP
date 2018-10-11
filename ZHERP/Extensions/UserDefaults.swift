//
//  UserDefaults.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/22.
//  Copyright © 2018 MrParker. All rights reserved.
//
/*
 Documents：用来存储永久性的数据的文件 程序运行时所需要的必要的文件都存储在这里（数据库）itunes会自动备份这里面的文件
 //Document 主目录
 let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
 let path = documentPaths.first
 Library：用于保存程序运行期间生成的文件
 //Libaray目录
 let libPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
 let libPath = libPaths.first
 Caches：文件夹用于保存程序运行期间产生的缓存文件
 //Cache目录
 let cachePaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
 let cachePath = cachePaths.first
 Preferences：主要是保存一些用户偏好设置的信息，一般情况下，我们不直接打开这个文件夹 而是通过NSUserDefaults进行偏好设置的存储
 
 tmp：临时文件夹---程序运行期间产生的临时岁骗会保存在这个文件夹中 通常文件下载完之后或者程序退出的灰自动清空此文件夹itunes不会备份这里的数据。
 tips： 由于系统会清空此文件夹所以下载或者其他临时文件若需要持久化请及时移走
 
 作者：smalldu
 链接：https://www.jianshu.com/p/dc4311cb3ce4
 來源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 */

import Foundation
import UIKit

extension UserDefaults {
    //应用第一次启动
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunched = "hasBeenLaunched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    //当前版本第一次启动
    static func isFirstLaunchOfNewVersion() -> Bool {
        //主程序版本号
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
        
        //上次启动的版本号
        let hasBeenLaunchedOfNewVersion = "hasBeenLaunchedOfNewVersion"
        let lastLaunchVersion = UserDefaults.standard.string(forKey: hasBeenLaunchedOfNewVersion)
        
        //版本号比较
        let isFirstLaunchOfNewVersion = majorVersion != lastLaunchVersion
        if isFirstLaunchOfNewVersion {
            UserDefaults.standard.set(majorVersion, forKey: hasBeenLaunchedOfNewVersion)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunchOfNewVersion
    }
    
    func setDefault(key:String,value:AnyObject?){
        if value == nil{
            UserDefaults.standard.removeObject(forKey: key)
        }else{
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize() //同步
        }
    }
    
    func removeUserDefault(key:String?){
        if key != nil{
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getDefault(key:String) ->AnyObject?{
        return UserDefaults.standard.value(forKey: key) as AnyObject
    }
    
}

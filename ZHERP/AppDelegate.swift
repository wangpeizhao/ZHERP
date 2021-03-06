//
//  AppDelegate.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/13.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //向APNs请求token
        UIApplication.shared.registerForRemoteNotifications()
        
//        let status: Bool = checkLoginStatus()
//        let vc: UIViewController!
//        if status {
//            vc = HomeViewController()
//        } else {
//            vc = LoginViewController()
//        }
//        self.window = UIWindow.init(frame: UIScreen.main.bounds)
//        self.window?.backgroundColor = UIColor.white
//        let nav = UINavigationController.init(rootViewController: vc)
//        self.window?.rootViewController = nav
//        self.window?.makeKeyAndVisible()
//        return true
        
        //判断当前版本是否第一次启动
        if UserDefaults.isFirstLaunchOfNewVersion() {
            //显示新功能介绍页
            print("当前版本第一次启动")
            let introductionViewController = IntroductionViewController()
            self.window!.rootViewController = introductionViewController
            return true
        }
        
        //判断是否第一次启动（两个都是第一次则以这个为准）
        if UserDefaults.isFirstLaunch() {
            //显示新手指导页
            print("应用第一次启动")
            let guideViewController = GuideViewController()
            self.window!.rootViewController = guideViewController
            return true
        }
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        let nav = UINavigationController(rootViewController: homeViewController)
////        appdelegate.window!.rootViewController = nav
//        self.window?.rootViewController = nav
//        self.window?.makeKeyAndVisible()
        
//        let firstVC = HomeViewController(nibName:nil,bundle: nil)
//        let navigation = UINavigationController(rootViewController: firstVC)
//        self.window?.rootViewController = navigation;
        
        
//        let LoginingView = LoginingViewController()
//        self.window!.rootViewController = LoginingView
        
        self.window?.rootViewController = LoginingViewController()
        
        self.window?.backgroundColor = Specs.color.white
        return true
    }
    //token请求回调
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //打印出获取到的token字符串
        print("Get Push token: \(deviceToken.hexString)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ZHERP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//对Data类型进行扩展
extension Data {
    //将Data转换为String
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}

//
//  ReachabilityChecking.swift
//  ZHERP
//
//  Created by MrParker on 2018/10/12.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation
//import Reachability

open class ReachabilityChecking {
    var reachability: Reachability?
    let hostNames = [nil, "baidu.com", "baima.com"]
    var hostIndex = 0
    
    var _view: UIView!
    
    
    open func startHost(at index: Int) {
        stopNotifier()
        setupReachability(hostNames[index], useClosures: true)
        startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.startHost(at: (index + 1) % 3)
        }
    }
    
    fileprivate func setupReachability(_ hostName: String?, useClosures: Bool) {
        let reachability: Reachability?
        if let hostName = hostName {
            reachability = Reachability(hostname: hostName)
            print("--- set up with host name: \(hostName)")
        } else {
            reachability = Reachability()
            print("--- set up with host name: \("No host name")")
        }
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
                self.updateLabelColourWhenReachable(reachability)
            }
            reachability?.whenUnreachable = { reachability in
                self.updateLabelColourWhenNotReachable(reachability)
            }
        } else {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged(_:)),
                name: .reachabilityChanged,
                object: reachability
            )
        }
    }
    
    open func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start\nnotifier")
            return
        }
    }
    
    open func stopNotifier() {
        print("--- stop notifier")
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    fileprivate func updateLabelColourWhenReachable(_ reachability: Reachability) {
        print("\(reachability.description) - \(reachability.connection)")
        if reachability.connection == .wifi {
//            self.networkStatus.textColor = .green
        } else {
//            self.networkStatus.textColor = .blue
        }
        
//        self.networkStatus.text = "\(reachability.connection)"
    }
    
    fileprivate func updateLabelColourWhenNotReachable(_ reachability: Reachability) {
        print("\(reachability.description) - \(reachability.connection)")
        
//        self.networkStatus.textColor = .red
        
//        self.networkStatus.text = "\(reachability.connection)"
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self._view, animated: true)
        //纯文本模式
        hud.mode = .text
        //设置提示标题
        hud.label.text = "网络检查"
        //设置提示详情
        hud.detailsLabel.text = "\(reachability.connection)"
        hud.removeFromSuperViewOnHide = true //隐藏时从父视图中移除
        hud.hide(animated: true, afterDelay: 5)  //2秒钟后自动隐藏
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .none {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }
}

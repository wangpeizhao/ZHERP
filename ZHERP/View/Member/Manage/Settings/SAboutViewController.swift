//
//  SAboutViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/20.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import WebKit

class SAboutViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var navHeight: CGFloat!
    lazy private var webview: WKWebView = {
        self.webview = WKWebView.init(frame: self.view.bounds)
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        return self.webview
    }()
    
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: 2))
        self.progressView.tintColor = UIColor.green      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "关于纵横")
        
        view.addSubview(webview)
        view.addSubview(progressView)
        
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webview.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com/")!))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("开始获取网页内容")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        webview.removeObserver(self, forKeyPath: "estimatedProgress")
        webview.uiDelegate = nil
        webview.navigationDelegate = nil
    }
}

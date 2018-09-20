//
//  SResponsibilityViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/20.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import WebKit

class SResponsibilityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "责任协议")
        
        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setUp() {
//        let homeDirectory = NSHomeDirectory()
        let path = Bundle.main.path(forResource: "responsibility", ofType: ".html", inDirectory: "HTML")
        let url = URL(fileURLWithPath:path!)
        let request = URLRequest(url:url)
        
        //将浏览器视图全屏(在内容区域全屏,不占用顶端时间条)
        let frame = CGRect(x:0, y:20, width: ScreenWidth, height: ScreenHeight)
        let theWebView:WKWebView = WKWebView(frame:frame)
        //禁用页面在最顶端时下拉拖动效果
        theWebView.scrollView.bounces = false
        //加载页面
        theWebView.load(request)
        self.view.addSubview(theWebView)
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

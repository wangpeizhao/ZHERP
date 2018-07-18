//
//  LoggingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/18.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class LoggingViewController: UIViewController {

    @IBAction func LoginBtn(_ sender: Any) {
        let vc = MemberViewController()
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let leftBtn:UIBarButtonItem=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: "actionBack")
        
        leftBtn.title="返回";
        
        leftBtn.tintColor=UIColor.white;
//        self.navigationItem
        self.navigationItem.leftBarButtonItem=leftBtn;
        // Do any additional setup after loading the view.
        
        
//        barBtn.setBackButtonTitlePositionAdjustment( UIOffset(horizontal:0 , vertical: -70), for: .default) //设置取消返回按钮的字体
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Logging"
        let leftBtn:UIBarButtonItem=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: "actionBack")
        
        leftBtn.title="返回";
        
        leftBtn.tintColor=UIColor.white;
        //        self.navigationItem
        self.navigationItem.leftBarButtonItem=leftBtn;
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

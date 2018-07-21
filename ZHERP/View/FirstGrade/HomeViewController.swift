//
//  HomeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var pickingBtn: UIButton!
    @IBOutlet weak var scanSendGoodBtn: UIButton!
    @IBOutlet weak var allocatingBtn: UIButton!
    @IBOutlet weak var warehouseBtn: UIButton!
    @IBOutlet weak var takeStockBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    
    
    @IBAction func PickingBtnClicked(_ sender: Any) {
    }
    @IBAction func ScanSendGoodBtnClicked(_ sender: Any) {
    }
    @IBAction func AllocatingBtnClicked(_ sender: Any) {
    }
    @IBAction func WarehouseBtnClicked(_ sender: Any) {
    }
    @IBAction func TakeStockBtnClicked(_ sender: Any) {
    }
    @IBAction func SettingBtnClicked(_ sender: Any) {
    }
    
    var vc: UIViewController!
    var withNav: Bool!
    
    @IBAction func MemberCenter(_ sender: Any) {
        if(checkLoginStatus()) {
            _open(view: self, vcName: "member")
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
    
    @IBOutlet weak var homeTxt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set bar
        setNavBarTitle(view: self, title: "纵横ERP", transparent: false)
        
        // set back btn
        let selector: Selector = #selector(actionGo)
        setBackBtn(view: self, selector: selector, title: "我的", parent: false)
        
        // 按钮圆形
        setUIButtonToCircle(button: pickingBtn)
        setUIButtonToCircle(button: scanSendGoodBtn)
        setUIButtonToCircle(button: allocatingBtn)
        setUIButtonToCircle(button: warehouseBtn)
        setUIButtonToCircle(button: takeStockBtn)
        setUIButtonToCircle(button: settingBtn)
    }
    
    @objc func actionGo() {
        if(checkLoginStatus()) {
            _open(view: self, vcName: "member")
        } else {
            _open(view: self, vcName: "login", withNav: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if(checkLoginStatus()) {
//            _open(view: self, vcName: "home")
//        } else {
//            _open(view: self, vcName: "login", withNav: false)
//        }
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

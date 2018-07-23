//
//  SettingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/23.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tablwView: UITableView!
    private var dataArray: [String] = []
    private var urlDict: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setNavBarTitle(view: self, title: "Setting")
        setNavBarTitle(view: self, title: "Setting")

//        // Do any additional setup after loading the view.
//        let textF=UITextField(frame: CGRect(x: 20, y: 100, width: 320, height: 36))
//        //设置textF边框，默认空白边框
//        textF.borderStyle=UITextBorderStyle.bezel
//        self.view.addSubview(textF)
//
//
//        //设置背景色
//        textF.backgroundColor=UIColor.gray
//        //设置文字颜色
//        textF.textColor=UIColor.blue
//        //设置字体颜色等
//        textF.font=UIFont(name: "Chalkduster", size: 30)
//        //文字编辑的时候现实清除按钮。默认不显示
//        textF.clearButtonMode=UITextFieldViewMode.whileEditing
//        //文本框对应的键盘样式，枚举类型，其他类型大家可以自行尝试
//        textF.keyboardType=UIKeyboardType.URL
//        //设置键盘右下角按钮文字
//        textF.returnKeyType=UIReturnKeyType.search
//        //点击文本框会调用
//        textF.addTarget(self, action: Selector(("testAct:")), for: UIControlEvents.touchDown)
//        //用户点击return按钮后调用的方法，首先设置代理，然后实现textFieldShouldReturn。点击按钮会会调用代理方法
//        textF.delegate=self as? UITextFieldDelegate
//
//        //20, 150, 320, 36
//        let textF1=UITextField(frame: CGRect(x: 20, y: 150, width: 320, height: 36))
//        //设置textF边框，默认空白边框
//        textF1.borderStyle=UITextBorderStyle.none
//        self.view.addSubview(textF1)
//
//        //设置为密码输入框
//        textF1.isSecureTextEntry=true
//
//        let textF2=UITextField(frame: CGRect(x: 20, y: 200, width: 320, height: 36))
//        //设置textF边框，默认空白边框
//        textF2.borderStyle=UITextBorderStyle.line
//        self.view.addSubview(textF2)
//
//        let textF3=UITextField(frame: CGRect(x: 20, y: 250, width: 320, height: 36))
//        //设置textF边框，默认空白边框
//        textF3.borderStyle=UITextBorderStyle.roundedRect
//        self.view.addSubview(textF3)
        
        makeData()
        
    }
    private func makeData() {
        
        urlDict = [
            "系统设置": UIApplicationOpenSettingsURLString,
            "个人热点":"prefs:root=INTERNET_TETHERING",
            "WIFI设置":"prefs:root=WIFI",
            "蓝牙设置":"prefs:root=Bluetooth",
            "系统通知":"prefs:root=NOTIFICATIONS_ID",
            "通用设置":"prefs:root=General",
            "显示设置":"prefs:root=DISPLAY&BRIGHTNESS",
            "壁纸设置":"prefs:root=Wallpaper",
            "声音设置":"prefs:root=Sounds",
            "隐私设置":"prefs:root=privacy",
            "蜂窝网路":"prefs:root=MOBILE_DATA_SETTINGS_ID",
            "音乐":"prefs:root=MUSIC",
            "APP Store":"prefs:root=STORE",
            "Notes":"prefs:root=NOTES",
            "Safari":"prefs:root=Safari",
            "Music":"prefs:root=MUSIC",
            "photo":"prefs:root=Photos"
        ]
        dataArray = Array(urlDict.keys)
    }
    
    
}

extension SettingViewController {
    
    /// 跳转到系统设置主页
    func jumpToSystemSeting() {
        let settingUrl = URL(string: UIApplicationOpenSettingsURLString)
        if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    /// 定位服务
    func jumpToPosition() {
        let settingUrl = URL(string: "prefs:root=LOCATION_SERVICES")
        if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    /// wifi服务
    func jumpToWifi() {
        let settingUrl = URL(string: "prefs:root=WIFI")
        if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
    /// 系统通知
    func jumpToNoti() {
        let settingUrl = URL(string: "prefs:root=NOTIFICATIONS_ID")
        if let url = settingUrl, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
    /// 跳转的模版
    func jumpTemplate(strurl: String) {
        let urltemp = URL(string: strurl)
        if let url = urltemp, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = urlDict[dataArray[indexPath.row]]
        if let strUrl = url {
            jumpTemplate(strurl: strUrl)
        }
    }

    func testAct(textF: UITextField){
        print("asdfasd")
        print(textF.text!)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //打印方法
        print(textField.text!)
        return true
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

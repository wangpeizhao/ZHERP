//
//  EditPersonalViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/24.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class EditPersonalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var personalValue: String? = nil
    var personalTitle: String? = nil
    var personalKey: String? = nil
    
    let identify:String = "SwiftCell"
    var items:[String] = ["男","女"]
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.grayBg
        
        setNavBarTitle(view: self, title: personalTitle!, transparent: false, ofSize: 18)
        
        let selector: Selector = #selector(actionSave)
        
        
        switch personalKey {
        case "myQR":
            _myQR()
            setNavBarRightBtn(view: self, title: "···", selector: #selector(selectorMyQR))
            break
        case "username":
            _username()
            setNavBarRightBtn(view: self, title: "保存", selector: selector, color: Specs.color.green)
            break
        case "signature":
            _signature()
            setNavBarRightBtn(view: self, title: "保存", selector: selector, color: Specs.color.green)
            break
        case "sex":
            _sex()
            break
        default:
            _username()
            setNavBarRightBtn(view: self, title: "保存", selector: selector)
            break
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        print("EditPersonalViewController actionSave ")
//        _alert(view: self, message: "保存成功", handler: _sure)
        _tip(view: self)
    }
    
    @objc func selectorMyQR() {
        let alertController = UIAlertController(title: "我的二维码", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "保存图片", style: .default, handler: saveBtn)
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveBtn(alert: UIAlertAction) {
        let frame = self.view.frame
        UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height - 100))
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(signature, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var showMessage = ""
        if error != nil{
            showMessage = "保存失败"
        }else{
            showMessage = "保存成功"
        }
        _tip(view: self, title: showMessage)
    }
    
    func _sure(alert: UIAlertAction!) {
        _back(view: self)
    }
    
    func _username() {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        //设置textField边框，默认空白边框
        field.borderStyle = UITextBorderStyle.none
        field.clearButtonMode = UITextFieldViewMode.always
        field.backgroundColor = Specs.color.white
        field.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = UITextFieldViewMode.always
        field.text = personalValue
        field.becomeFirstResponder() //文本框在界面打开时就获取焦点，并弹出输入键盘
        field.resignFirstResponder() //文本框失去焦点，并收回键盘
        field.adjustsFontSizeToFitWidth = true  //当文字超出文本框宽度时，自动调整文字大小
        field.minimumFontSize = 14  //最小可缩小的字号
        self.view.addSubview(field)
        
        field.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(84)
            make.height.equalTo(40)
        }
    }
    
    func _myQR() {
        self.view.backgroundColor = Specs.color.black
        
        let imageView = UIImageView()
        
        imageAdaptive(imageView: imageView, imageName: personalValue!)
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.center.equalTo(self.view)
        }
    }
    
    func _sex() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        //去除单元格分隔线
        self.tableView!.separatorStyle = .singleLine
        //去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.view.addSubview(self.tableView!)
    }
    
    func _signature() {
        let field = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        //设置textField边框，默认空白边框
        field.layer.backgroundColor = Specs.color.white.cgColor
//        field.font = UIFont(name: "", size: 18)
        field.font = UIFont.systemFont(ofSize: 18)
        field.text = personalValue
        field.dataDetectorTypes = UIDataDetectorTypes.all
        self.view.addSubview(field)
        
        field.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(84)
            make.height.equalTo(100)
        }
    }
    
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        //判断是否选中（选中单元格尾部打勾）
        if selectedIndexs.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //判断该行原先是否选中
        if let index = selectedIndexs.index(of: indexPath.row){
            selectedIndexs.remove(at: index) //原来选中的取消选中
        }else{
            selectedIndexs.removeAll() // 单选
            selectedIndexs.append(indexPath.row) //原来没选中的就选中
        }
        self.tableView?.reloadData()
        _back(view: self)
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

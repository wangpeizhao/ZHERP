//
//  GoodOperateSViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/21.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit
import Photos

class GoodOperateSViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navTitle: String!
    
    // 初始数据
    var valueArr = [String: String]()
    
    // 回调赋值
    var callBackAssign: assignArrayClosure?
    
    // 字段数据
    var dataArr = [[String: Any]]()
    
    // 数据model
    var _initData: GoodModel?
    
    // 是否是添加货品调配
    var _isAdd: Bool!
    
    // 添加时选择货品分类
    var categoryName: String = ""
    // 添加时选择所属仓库
    var warehouseName: String = ""
    // 添加时选择所属库位
    var locationName: String = ""
    // 添加时选择供应商
    var supplierName: String = ""
    // 添加时选择货品单位
    var unitName: String = ""
    
    var selectImgs:[UIImage] = []
    
    var _picImageViewDemo: UIImageView!
    
    var allowsEditing: Bool = false
    
    let writableTextFields = ["sn", "title", "salePrice", "costPrice", "quantity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle != nil ? self.navTitle: "添加货品")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack()->Void {
        _back(view: self)
    }
    
    @objc func actionSuccess(_: UIAlertAction)->Void {
        for i in 0..<(self.navigationController?.viewControllers.count)! {
            if self.navigationController?.viewControllers[i].isKind(of: HDeliverViewController.self) == true {
                _ = self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! HDeliverViewController, animated: true)
                break
            }
        }
    }
    
    @objc func actionTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        switch sender.tag {
        case 1001:
            self._initData?.sn = sender.text!
            break
        case 1002:
            self._initData?.title = sender.text!
            break
        case 1003:
            self._initData?.salePrice = sender.text!
            break
        case 1004:
            self._initData?.costPrice = sender.text!
            break
        case 1005:
            self._initData?.quantity = sender.text!
            break
        default:
            break
        }
        //        self._initData?.quantity = sender.text!
    }
    
    @objc func actionSave() {
        //        print(self._initData as Any)
//        if (self._initData?.receiver == "") {
//            _alert(view: self, message: "请先填写收件人")
//            return
//        }
        if (self.callBackAssign != nil) {
            if (self.valueArr["maxId"] != nil) {
                self.valueArr["id"] = self.valueArr["maxId"]
            }
            self.callBackAssign!(self.valueArr)
        }
        _alert(view: self, message: "提交成功", handler: actionSuccess)
    }
    
    @objc func actionAddImg() {
        let alertController = UIAlertController(title: "请选择图片来源", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "拍照", style: .destructive, handler: actionCamera)
        let archiveAction = UIAlertAction(title: "从手机相册选择", style: .default, handler: actionPhotoAlbum)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func actionCamera(alert: UIAlertAction) {
        let pickerPhoto = UIImagePickerController()
        pickerPhoto.sourceType = .camera
        pickerPhoto.allowsEditing = self.allowsEditing
        pickerPhoto.delegate = self
        self.present(pickerPhoto, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage! // = info[UIImagePickerControllerOriginalImage] as! UIImage
        if self.allowsEditing {
            //获取编辑后的图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //获取选择的原图
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        self._picImageViewDemo.image = image?.crop(ratio: 1)
        self._picImageViewDemo.tag = 0
        self.selectImgs.append((image?.crop(ratio: 1))!)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel...")
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func actionPhotoAlbum(alert: UIAlertAction) {
        //开始选择照片，最多允许选择4张
        _ = self.presentHGImagePicker(maxSelected:9) { (assets) in
            //结果处理
            print("共选择了\(assets.count)张图片，分别如下：")
            for asset in assets {
                print(asset)
                //获取缩略图
                //根据单元格的尺寸计算我们需要的缩略图大小
                //                let scale = UIScreen.main.scale
                //                let cellSize = (self.collectionView.collectionViewLayout as!
                //                    UICollectionViewFlowLayout).itemSize
                
                let imageManager = PHCachingImageManager()
                let assetGridThumbnailSize = CGSize(width: 50 , height: 50)
                imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (image, nfo) in
                    self._picImageViewDemo.image = image?.crop(ratio: 1)
                    self._picImageViewDemo.tag = 0
                    
                }
                
                // 获取原图
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { image, info in
                    self.selectImgs.append((image?.crop(ratio: 1))!)
                })
                
                //获取文件名
                PHImageManager.default().requestImageData(for: asset, options: nil, resultHandler: { _, _, _, info in
                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
                })
                
                //获取图片信息
                let info = "日期：\(asset.creationDate!)\n"
                    + "类型：\(asset.mediaType.rawValue)\n"
                    + "位置：\(String(describing: asset.location))\n"
                    + "时长：\(asset.duration)\n"
                print(info)
            }
        }
    }
    
    private func _setup() {
        self.initData()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        
        //处理键盘遮挡问题
        if (self._isAdd) {
            let tvc: UITableViewController = UITableViewController(style: .grouped)
            self.addChildViewController(tvc)
            self.tableView = tvc.tableView
        }
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        
        if (self._isAdd) {
            // 可填写
            self.tableView?.register(UINib(nibName: "SMemberOperateTableViewCell", bundle: nil), forCellReuseIdentifier: "SMemberOperateTableViewCell")
            // 按钮
            self.tableView?.register(UINib(nibName: "HDeliveringTableViewCell", bundle: nil), forCellReuseIdentifier: "HDeliveringTableViewCell")
        }
        
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        self.view.addSubview(self.tableView!)
    }
    
    private func initData() {
        self._isAdd = self.valueArr["datetime"] == nil
        
        self._initData = GoodModel(id: 0, category: "", cId: 0, warehouse: "", wId: 0, location: "", lId: 0, supplier: "", sId: 0, unit: "", uId: 0, sn: "", title: "", salePrice: "", costPrice: "", quantity: "", employee: "", datetime: dateFromString(SYSTEM_DATETIME, format: "yyyy-MM-dd HH:mm:ss")!)
        
        if self.valueArr["datetime"] == nil {
            self.valueArr["datetime"] = SYSTEM_DATETIME
        }
        self._initData?.id = self.valueArr["id"] != nil ? Int(self.valueArr["id"]!)! : 0
        self._initData?.category = self.valueArr["category"] != nil ? self.valueArr["category"]! : "未选择(必选项)"
        self._initData?.cId = self.valueArr["cId"] != nil ? Int(self.valueArr["cId"]!)! : 0
        self._initData?.warehouse = self.valueArr["warehouse"] != nil ? self.valueArr["warehouse"]! : "未选择(选填项)"
        self._initData?.wId = self.valueArr["wId"] != nil ? Int(self.valueArr["wId"]!)! : 0
        self._initData?.location = self.valueArr["location"] != nil ? self.valueArr["location"]! : "未选择(选填项)"
        self._initData?.lId = self.valueArr["lId"] != nil ? Int(self.valueArr["lId"]!)! : 0
        self._initData?.supplier = self.valueArr["supplier"] != nil ? self.valueArr["supplier"]! : "未选择(选填项)"
        self._initData?.sId = self.valueArr["sId"] != nil ? Int(self.valueArr["sId"]!)! : 0
        self._initData?.unit = self.valueArr["unit"] != nil ? self.valueArr["unit"]! : "未选择(选填项)"
        self._initData?.uId = self.valueArr["uId"] != nil ? Int(self.valueArr["uId"]!)! : 0
        
        self._initData?.sn = self.valueArr["expressNumber"] != nil ? self.valueArr["expressNumber"]! : ""
        self._initData?.title = self.valueArr["title"] != nil ? self.valueArr["title"]! : ""
        self._initData?.salePrice = self.valueArr["salePrice"] != nil ? self.valueArr["salePrice"]! : ""
        self._initData?.costPrice = self.valueArr["costPrice"] != nil ? self.valueArr["costPrice"]! : ""
        self._initData?.quantity = self.valueArr["quantity"] != nil ? self.valueArr["quantity"]! : ""
        
        self._initData?.employee = self.valueArr["employee"] != nil ? self.valueArr["employee"]! : ""
        self._initData?.datetime = dateFromString(self.valueArr["datetime"]!, format: "yyyy-MM-dd HH:mm:ss")!
        
        self.dataArr = [
            [
                "title": "货品信息",
                "rows": [
                    ["title":"货品编号", "key":"sn", "value": self._initData?.sn, "placeholder": "请填写货品编号"],
                    ["title":"货品名称", "key":"title", "value": self._initData?.title, "placeholder": "请填写货品名称"],
                    ["title":"销售价格", "key":"salePrice", "value": self._initData?.salePrice, "placeholder": "请填写销售价格"],
                    ["title":"成本价格", "key":"costPrice", "value": self._initData?.costPrice, "placeholder": "请填写成本价格"],
                    ["title":"货品数量", "key":"quantity", "value": self._initData?.quantity, "placeholder": "请填写货品数量"],
                    ["title":"货品单位", "key":"unit", "value": self._initData?.unit],
                ]
            ],
            [
                "title": "仓库信息",
                "rows": [
                    ["title":"所在仓库", "key":"warehouse", "value": self._initData?.warehouse],
                    ["title":"所在库位", "key":"location", "value": self._initData?.location],
                    ["title":"供应商", "key":"supplier", "value": self._initData?.supplier]
                ]
            ],
            [
                "title": "员工信息",
                "rows": [
                    ["title":"添加时间", "key":"datetime", "value": stringFromDate((self._initData?.datetime)!, format: "yyyy-MM-dd HH:mm:ss")],
                    ["title":"添加员工", "key":"employee", "value": self._initData?.employee]
                ]
            ],
            [
                "title": "别忘了点击提交按钮喔",
                "rows": [
                    ["title":"提交", "key":"submit", "value": ""]
                ]
            ]
        ]
        
        if self._isAdd {
            self.dataArr.removeAt(indexes: [2])
        } else {
//            self.dataArr.removeAt(indexes: [4])
        }
    }
    
    fileprivate func _rowsModel(at section: Int) -> [Any] {
        return self.dataArr[section]["rows"] as! [Any]
    }
    
    fileprivate func _rowModel(at indexPath: IndexPath) -> [String: String] {
        return self._rowsModel(at: indexPath.section)[indexPath.row] as! [String : String]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //移除监听
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension GoodOperateSViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._rowsModel(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.dataArr[section]["title"] as! String)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self._isAdd == true && indexPath.section == self.dataArr.count - 1 {
            return SelectCellHeight + 10
        }
        return SelectCellHeight
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 160
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let _picView = UIView()
            _picView.backgroundColor = UIColor.clear
            
            let _tipView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
            _tipView.backgroundColor = UIColor.hexInt(0xfff0ba)
            _picView.addSubview(_tipView)
            
            let _tipLabel = UILabel()
            _tipView.addSubview(_tipLabel)
            _tipLabel.sizeToFit()
            _tipLabel.textAlignment = .left
            _tipLabel.font = Specs.font.regular
            _tipLabel.textColor = UIColor.hexInt(0xab7548)
            _tipLabel.text = "温馨提示：上传货品图片上传货品图片，最多九张，最多九张"
            _tipLabel.snp.makeConstraints { (make) -> Void in
                make.left.right.equalTo(20)
                make.height.equalTo(20)
                make.top.equalTo(10)
            }
            
            let _tip2Label = UILabel()
            _tipView.addSubview(_tip2Label)
            _tip2Label.sizeToFit()
            _tip2Label.textAlignment = .left
            _tip2Label.font = Specs.font.regular
            _tip2Label.textColor = UIColor.hexInt(0xab7548)
            _tip2Label.text = "长按图片可更换位置"
            _tip2Label.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(90)
                make.right.equalTo(20)
                make.height.equalTo(20)
                make.top.equalTo(30)
            }
            
            let _picImageView = UIImageView()
            let _img = UIImage(named: "Add-details-of-the-plan")
            _picImageView.image = _img
            
            // 为UIImageView添加Tap手势
            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(actionAddImg))
            _picImageView.addGestureRecognizer(singleTapGesture)
            _picImageView.isUserInteractionEnabled = true
            
            _picView.addSubview(_picImageView)
            _picImageView.snp.makeConstraints {(make) -> Void in
                make.top.equalTo(_tipView.snp.bottom).offset(12)
                make.left.equalTo(20)
            }
            
            self._picImageViewDemo = UIImageView()
            let _img1 = UIImage(named: "Add-details-of-the-plan")
            self._picImageViewDemo.image = _img1
            
            self._picImageViewDemo.tag = 0
            
            //添加单击监听
            let tapSingle=UITapGestureRecognizer(target:self, action:#selector(imageViewTap(_:)))
            tapSingle.numberOfTapsRequired = 1
            tapSingle.numberOfTouchesRequired = 1
            self._picImageViewDemo.addGestureRecognizer(tapSingle)
            self._picImageViewDemo.isUserInteractionEnabled = true
            
            
            _picView.addSubview(self._picImageViewDemo)
            self._picImageViewDemo.snp.makeConstraints {(make) -> Void in
                make.left.equalTo(_picImageView.snp.right).offset(10)
                make.top.equalTo(_picImageView.snp.top)
                make.width.height.equalTo(78)
            }
            
            return _picView
        }
        return UIView()
    }
    
    //缩略图imageView点击
    @objc func imageViewTap(_ recognizer:UITapGestureRecognizer){
        print("imageViewTap")
        //图片索引
        let index = recognizer.view!.tag
        //进入图片全屏展示
        let previewVC = HGImagePreviewVC(images: self.selectImgs, index: index)
//        self.navigationController?.pushViewController(previewVC, animated: true)
        _push(view: self, target: previewVC, rootView: false)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self._isAdd == true && section == self.dataArr.count - 1 {
            return "别忘了点击提交按钮喔"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self._isAdd == true || section != self.dataArr.count - 1 {
            return UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        }
        let memberView = UIView()
        memberView.backgroundColor = UIColor.clear
        
        let _btn = UIButton(frame: CGRect(x: 20, y: 20, width: ScreenWidth - 40, height: 40))
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        
        _btn.setTitle("返回", for: .normal)
        _btn.setTitleColor(Specs.color.black, for: UIControlState())
        _btn.backgroundColor = Specs.color.white
        _btn.layer.borderWidth = 1
        _btn.layer.borderColor = UIColor(hex: 0xdddddd).cgColor //UIColor.lightGray.cgColor
        _btn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        
        memberView.addSubview(_btn)
        
        return memberView
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self._isAdd == false && section == self.dataArr.count - 1 {
            return 80
        }
        return 20
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        if key == "submit" {
            let cell: HDeliveringTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HDeliveringTableViewCell") as! HDeliveringTableViewCell
            cell.cellBtn.setTitle("提交", for: .normal)
            cell.cellBtn.setTitleColor(Specs.color.white, for: UIControlState())
            cell.cellBtn.backgroundColor = Specs.color.main
            cell.cellBtn.layer.cornerRadius = Specs.border.radius
            cell.cellBtn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
            return cell
        }
        
        if (self._isAdd == true && self.writableTextFields.contains(key)) {
            let cell: SMemberOperateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SMemberOperateTableViewCell") as! SMemberOperateTableViewCell
            cell.TextFieldLabel.text = _row["title"]
            cell.TextFieldLabel.sizeToFit()
            cell.TextFieldLabel.font = Specs.font.regular
            
            switch key {
            case "sn":
                cell.TextFieldValue.tag = 1001
                cell.TextFieldValue.keyboardType = UIKeyboardType.alphabet
                break
            case "title":
                cell.TextFieldValue.tag = 1002
                break
            case "salePrice":
                cell.TextFieldValue.tag = 1003
                cell.TextFieldValue.keyboardType = UIKeyboardType.decimalPad
                break
            case "costPrice":
                cell.TextFieldValue.tag = 1004
                cell.TextFieldValue.keyboardType = UIKeyboardType.decimalPad
                break
            case "quantity":
                cell.TextFieldValue.tag = 1005
                cell.TextFieldValue.keyboardType = UIKeyboardType.decimalPad
                break
            default:
                cell.TextFieldValue.tag = indexPath.row
                break
            }
            
            cell.TextFieldValue.text = _row["value"]
            cell.TextFieldValue.textColor = Specs.color.black
            cell.TextFieldValue.placeholder = _row["placeholder"]
            cell.TextFieldValue.clearButtonMode = UITextFieldViewMode.always
            cell.TextFieldValue.adjustsFontSizeToFitWidth = true
            cell.TextFieldValue.returnKeyType = UIReturnKeyType.done
            cell.TextFieldValue.delegate = self
            
            cell.accessoryType = .none
            return cell
        }
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _row["title"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _row["value"]
        
        if self._isAdd == true && key == "warehouse" && self.warehouseName != "" {
            cell.detailTextLabel?.text = self.warehouseName
        }
        
        if self._isAdd == true && key == "location" && self.locationName != "" {
            cell.detailTextLabel?.text = self.locationName
        }
        
        if self._isAdd == true && key == "supplier" && self.supplierName != "" {
            cell.detailTextLabel?.text = self.supplierName
        }
        
        if self._isAdd == true && key == "unit" && self.unitName != "" {
            cell.detailTextLabel?.text = self.unitName
        }
        
        cell.detailTextLabel?.font = Specs.font.regular
        
        let _edit = ["employee", "datetime", "orderId", "orderAmountPaid", "orderTime"]
        if (self._isAdd == false || _edit.contains(key)) {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self._isAdd == false {
            return
        }
        
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        let _target = GoodOperateFViewController()
        switch key {
        case "category":
            _target.dataType = .category
            _target.navTitle = "选择货品分类"
            if self._initData?.cId != 0 {
                _target.selectedIds.append((self._initData?.cId)!)
            }
        case "warehouse":
            _target.dataType = .warehouse
            _target.navTitle = "选择所属仓库"
            if self._initData?.wId != 0 {
                _target.selectedIds.append((self._initData?.wId)!)
            }
        case "location":
            _target.dataType = .location
            _target.navTitle = "选择所属库位"
            if self._initData?.lId != 0 {
                _target.selectedIds.append((self._initData?.lId)!)
            }
        case "supplier":
            _target.dataType = .supplier
            _target.navTitle = "选择供应商"
            if self._initData?.sId != 0 {
                _target.selectedIds.append((self._initData?.lId)!)
            }
        case "unit":
            _target.dataType = .unit
            _target.navTitle = "选择货品单位"
            if self._initData?.uId != 0 {
                _target.selectedIds.append((self._initData?.uId)!)
            }
        default:
            break
        }
        _target.callBackAssignArray = {(assignValue: [String: String]) -> Void in
            if (!assignValue.isEmpty) {
                switch _target.dataType {
                case .category:
                    self._initData?.cId = Int(assignValue["id"]!)!
                    self._initData?.category = assignValue["name"]!
                    self.categoryName = assignValue["name"]!
                case .warehouse:
                    self._initData?.wId = Int(assignValue["id"]!)!
                    self._initData?.warehouse = assignValue["name"]!
                    self.warehouseName = assignValue["name"]!
                case .location:
                    self._initData?.lId = Int(assignValue["id"]!)!
                    self._initData?.location = assignValue["name"]!
                    self.locationName = assignValue["name"]!
                case .supplier:
                    self._initData?.sId = Int(assignValue["id"]!)!
                    self._initData?.supplier = assignValue["name"]!
                    self.supplierName = assignValue["name"]!
                case .unit:
                    self._initData?.sId = Int(assignValue["id"]!)!
                    self._initData?.unit = assignValue["name"]!
                    self.unitName = assignValue["name"]!
                default:
                    break
                }
                tableView.reloadData()
            }
        }
        _push(view: self, target: _target, rootView: false)
    }
}

extension GoodOperateSViewController: UITextFieldDelegate {
    // 输入框询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    // 输入框结束编辑状态
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.actionTextField(textField)
    }
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.actionTextField(textField)
        return true
    }
}

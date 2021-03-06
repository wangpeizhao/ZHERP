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

class GoodOperateSViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GoodOperateImageViewDelegate {
    
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
    
    // 已选择的照片
    var selectImgs:[UIImage] = []
    // 最多允许上传照片数量
    let maxGoodImages: Int = 8
    
    
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
        self._initDataArr()
    }
    
    @objc func actionSave() {
        if (self._initData?.sn == "") {
            _alert(view: self, message: "请填写货品编号", handler: actionBecomeFirstResponder)
            return
        }
        if (self._initData?.title == "") {
            _alert(view: self, message: "请填写货品名称", handler: actionBecomeFirstResponder)
            return
        }
        if (self._initData?.salePrice == "") {
            _alert(view: self, message: "请填写销售价格", handler: actionBecomeFirstResponder)
            return
        }
        if (self._initData?.costPrice == "") {
            _alert(view: self, message: "请填写成本价格", handler: actionBecomeFirstResponder)
            return
        }
        if (self.callBackAssign != nil) {
            if (self.valueArr["maxId"] != nil) {
                self.valueArr["id"] = self.valueArr["maxId"]
            }
            self.callBackAssign!(self.valueArr)
        }
        _alert(view: self, message: "提交成功", handler: actionSuccess)
    }
    
    @objc func actionBecomeFirstResponder(_: UIAlertAction)->Void {
        let _indexPath: IndexPath = IndexPath(row: 0, section: 0)
        let _cell: SMemberOperateTableViewCell = self.tableView.cellForRow(at: _indexPath as IndexPath) as! SMemberOperateTableViewCell
        _cell.TextFieldValue.becomeFirstResponder()
    }
    
    fileprivate func actionAddImg() {
        let alertController = UIAlertController(title: "请选择图片来源", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "拍照", style: .destructive, handler: actionCamera)
        let archiveAction = UIAlertAction(title: "从手机相册选择", style: .default, handler: actionPhotoAlbum)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //缩略图imageView点击
    fileprivate func imageViewPreview(row: Int) {
        //进入图片全屏展示
        let previewVC = HGImagePreviewVC(images: self.selectImgs, imagesURL: [], index: row)
        _push(view: self, target: previewVC, rootView: false)
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

        self.selectImgs.append((image?.crop(ratio: 1))!)
        self.tableView?.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func actionPhotoAlbum(alert: UIAlertAction) {
        //开始选择照片，最多允许选择4张
        _ = self.presentHGImagePicker(maxSelected: self.maxGoodImages - self.selectImgs.count) { (assets) in
            //结果处理
            for asset in assets {
                //获取缩略图
                //根据单元格的尺寸计算我们需要的缩略图大小
//                let scale = UIScreen.main.scale
//                let cellSize = (self.collectionView.collectionViewLayout as!
//                    UICollectionViewFlowLayout).itemSize
                
                let imageManager = PHCachingImageManager()
                let assetGridThumbnailSize = CGSize(width: 360 , height: 360)
                imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (image, nfo) in
//                    self.selectImgs.append((image?.crop(ratio: 1))!)
                }
                
                // 获取原图
//                let opt = PHImageRequestOptions()
//                opt.isSynchronous = true
//                opt.resizeMode = .fast
                DispatchQueue.main.async {
                    PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { image, info in
                        self.selectImgs.append((image?.crop(ratio: 1))!)
                        self.tableView?.reloadData()
                    })
                }
                
                //获取文件名
//                PHImageManager.default().requestImageData(for: asset, options: nil, resultHandler: { _, _, _, info in
//                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
//                })
                
                //获取图片信息
//                let info = "日期：\(asset.creationDate!)\n"
//                    + "类型：\(asset.mediaType.rawValue)\n"
//                    + "位置：\(String(describing: asset.location))\n"
//                    + "时长：\(asset.duration)\n"
//                print(info)
//                DispatchQueue.main.async {
//                    self.tableView?.reloadData()
//                }
            }
        }
    }
    
    private func _setup() {
        self.initData()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        
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
        self.tableView?.keyboardDismissMode = .onDrag
        self.view.addSubview(self.tableView!)
        
        //处理键盘遮挡问题
        if (self._isAdd) {
//            let tvc: UITableViewController = UITableViewController(style: .grouped)
//            self.addChildViewController(tvc)
//            self.tableView = tvc.tableView
        }
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
        
        self._initDataArr()
        
        if self._isAdd {
            self.dataArr.removeAt(indexes: [2])
        } else {
//            self.dataArr.removeAt(indexes: [4])
        }
    }
    
    fileprivate func _initDataArr() {
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
    }
    
    fileprivate func _rowsModel(at section: Int) -> [Any] {
        return self.dataArr[section]["rows"] as! [Any]
    }
    
    fileprivate func _rowModel(at indexPath: IndexPath) -> [String: String] {
        return self._rowsModel(at: indexPath.section)[indexPath.row] as! [String : String]
    }
    
    // 选中照片后预览或者添加更多
    public func didSelectItemAtImage(view: GoodOperateImageView, row: Int) {
        let _count = self.selectImgs.count
        if (row == 0 && _count == 0) || (row == _count) {
            if _count == 8 {
                _alert(view: self, message: "只允许上传\(self.maxGoodImages)张照片，请删除其他照片后再添加")
            } else {
                self.actionAddImg()
            }
        } else {
            self.imageViewPreview(row: row)
        }
        
    }
    
    // 删除照片
    public func deleteGoodImage(view: GoodOperateImageView, row: Int) {
        guard self.selectImgs.count == 0 else {
            self.selectImgs.remove(at: row)
            self.tableView.reloadData()
            return
        }
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
            return self.selectImgs.count > 3 ? 226 : 158
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let _goodImgView = GoodOperateImageView()
            _goodImgView.maxGoodImages = self.maxGoodImages
            _goodImgView._delegate = self
            let _img = UIImage(named: "Add-details-of-the-plan")
            _goodImgView.dataArr = self.selectImgs
            _goodImgView.dataArr.append(_img!)
            self.addChildViewController(_goodImgView)
            return _goodImgView.view
        }
        return UIView()
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
            let cell: HDeliveringTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HDeliveringTableViewCell", for: indexPath) as! HDeliveringTableViewCell
            cell.cellBtn.setTitle("提交", for: .normal)
            cell.cellBtn.setTitleColor(Specs.color.white, for: UIControlState())
            cell.cellBtn.backgroundColor = Specs.color.main
            cell.cellBtn.layer.cornerRadius = Specs.border.radius
            cell.cellBtn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
            return cell
        }
        
        if (self._isAdd == true && self.writableTextFields.contains(key)) {
            let cell: SMemberOperateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SMemberOperateTableViewCell", for: indexPath) as! SMemberOperateTableViewCell
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
                _target.selectedIds.append((self._initData?.sId)!)
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
                let _id = Int(assignValue["id"]!)!
                let _name = assignValue["name"]!
                switch _target.dataType {
                case .category:
                    self._initData?.cId = _id
                    self._initData?.category = _name
                    self.categoryName = _name
                case .warehouse:
                    self._initData?.wId = _id
                    self._initData?.warehouse = _name
                    self.warehouseName = _name
                case .location:
                    self._initData?.lId = _id
                    self._initData?.location = _name
                    self.locationName = _name
                case .supplier:
                    self._initData?.sId = _id
                    self._initData?.supplier = _name
                    self.supplierName = _name
                case .unit:
                    self._initData?.uId = _id
                    self._initData?.unit = _name
                    self.unitName = _name
                default:
                    break
                }
                tableView.reloadData()
//                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        _push(view: self, target: _target, rootView: false)
    }
}

extension GoodOperateSViewController: UITextFieldDelegate {
    // 输入框询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.actionTextField(textField)
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

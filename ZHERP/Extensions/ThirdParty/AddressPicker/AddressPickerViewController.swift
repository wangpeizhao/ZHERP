//
//  AddressPickerViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/2.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class AddressPickerViewController: UIViewController {
    
    var callBackAssign: assignValueClosure?
    
    //选择器
    var pickerView:UIPickerView!
    
    //所以地址数据集合
    var addressArray = [[String: AnyObject]]()
    
    //选择的省索引
    var provinceIndex = 0
    //选择的市索引
    var cityIndex = 0
    //选择的县索引
    var areaIndex = 0
    
    var invokingView: UIViewController!
    
    var province: String
    var city: String
    var area: String
    
    init(province: String, city: String, area: String) {
        self.province = province.trimmingCharacters(in: .whitespaces)
        self.city = city.trimmingCharacters(in: .whitespaces)
        self.area = area.trimmingCharacters(in: .whitespaces)
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }
    
    private func _setUp() {
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
        //初始化数据
        let path = Bundle.main.path(forResource: "address", ofType:"plist")
        self.addressArray = NSArray(contentsOfFile: path!) as! Array
        
        //创建选择器
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 20, width: ScreenWidth - 20, height: 200))
        //将dataSource设置成自己
        self.pickerView.dataSource = self
        //将delegate设置成自己
        self.pickerView.delegate = self
//        self.view.addSubview(self.pickerView)
        
        self._setInit()
    }
    
    private func _setInit() {
        if self.addressArray.count == 0 {
            return
        }
        
        var i: Int = 0
        // address
        for item in self.addressArray {
            // province
            if (!self.province.isEmpty && item["state"]! as! String == self.province) {
                self.provinceIndex = i
                let _province = self.addressArray[provinceIndex]
                let _cities = _province["cities"] as! [[String : AnyObject]]
                
                if (_cities.count == 0) {
                    break
                }
                
                var ii: Int = 0
                for _item in _cities {
                    // city
                    if (!self.city.isEmpty && _item["city"]! as! String == self.city) {
                        self.cityIndex = ii
                        let _areas = _item["areas"]! as! [String]
                        if (_areas.count == 0) {
                            break
                        }
                        
                        var iii: Int = 0
                        for _item_ in _areas {
                            // area
                            if (!self.area.isEmpty && _item_.hasPrefix(self.area) == true) {
                                self.areaIndex = iii
                                break
                            }
                            iii = iii + 1
                        }
                        break
                    }
                    ii = ii + 1
                }

                break
            }
            i = i + 1
        }
//        let message = "索引：\(provinceIndex)-\(cityIndex)-\(areaIndex)\n"
//            + "值：\(province) - \(city) - \(area)"
//        
//        print("message:\(message)")

    }
    
    public func setAddressPickerView(view: UIViewController){
        self.invokingView = view
        let alertController = UIAlertController(title: "请选择区域\n\n\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let DestructiveAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) {
            (result : UIAlertAction) -> Void in
            // todo
        }
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: getPickerViewValue)
        
        self._setUp()
        alertController.view.addSubview(self.pickerView)
        
//        self.provinceIndex = 5
//        self.cityIndex = 8
//        self.areaIndex = 1
        self.pickerView.selectRow(self.provinceIndex, inComponent: 0, animated: true)
        self.pickerView.selectRow(self.cityIndex, inComponent: 1, animated: true)
        self.pickerView.selectRow(self.areaIndex, inComponent: 2, animated: true)
        self.pickerView.reloadAllComponents()
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.invokingView.present(alertController, animated: true, completion: nil)
    }
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(_: UIAlertAction)->Void {
        
//        let selectedState = cCityPickerView?.selectedRow(inComponent: 0)
//        let selectedCity = cCityPickerView?.selectedRow(inComponent: 1)
//        let selectedArea = cCityPickerView?.selectedRow(inComponent: 2)
        
        //获取选中的省
        let p = self.addressArray[provinceIndex]
        let province = p["state"]!
        
        //获取选中的市
        let c = (p["cities"] as! NSArray)[cityIndex] as! [String: AnyObject]
        let city = c["city"] as! String
        
        //获取选中的县（地区）
        var area = ""
        if (c["areas"] as! [String]).count > 0 {
            area = (c["areas"] as! [String])[areaIndex]
        }
        
        if (self.callBackAssign != nil) {
            self.callBackAssign!("\(province) \(city) \(area)")
        }
        
//        //拼接输出消息
//        let message = "索引：\(provinceIndex)-\(cityIndex)-\(areaIndex)\n"
//            + "值：\(province) - \(city) - \(area)"
//
//        print("message:\(message)")
//
//        //消息显示
//        let alertController = UIAlertController(title: "您选择了", message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.invokingView.present(alertController, animated: true, completion: nil)
        
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

extension AddressPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.addressArray.count
        } else if component == 1 {
            let province = self.addressArray[provinceIndex]
            return province["cities"]!.count
        } else {
            let province = self.addressArray[provinceIndex]
            if let city = (province["cities"] as! NSArray)[cityIndex]
                as? [String: AnyObject] {
                return city["areas"]!.count
            } else {
                return 0
            }
        }
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.addressArray[row]["state"] as? String
        }else if component == 1 {
            let province = self.addressArray[provinceIndex]
            let city = (province["cities"] as! NSArray)[row]
                as! [String: AnyObject]
            return city["city"] as? String
        }else {
            let province = self.addressArray[provinceIndex]
            let city = (province["cities"] as! NSArray)[cityIndex]
                as! [String: AnyObject]
            return (city["areas"] as! NSArray)[row] as? String
        }
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        print("\(self.province) \(self.city) \(self.area)")
        
        //根据列、行索引判断需要改变数据的区域
        switch (component) {
        case 0:
            provinceIndex = row;
            cityIndex = 0;
            areaIndex = 0;
            pickerView.reloadComponent(1);
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 1:
            cityIndex = row;
            areaIndex = 0;
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 2:
            areaIndex = row;
        default:
            break;
        }
    }
    
}

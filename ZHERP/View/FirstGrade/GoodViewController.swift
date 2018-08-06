//
//  GoodViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class GoodViewController: UIViewController, UITextFieldDelegate {
    //搜索控制器
    
    @IBOutlet weak var textField: UITextField!
    var keyHeight = CGFloat() //键盘的高度
    
    // Search
    var searchController = UISearchController()
    var searchOffset: CGFloat!
    
    let searchHeight: CGFloat = 35
    
    var countrySearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textField.delegate = self
        
        let centerDefault = NotificationCenter.default
        
        centerDefault.addObserver(self, selector: #selector(GoodViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self   //两个样例使用不同的代理
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
//            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        self.view.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
        self.view.backgroundColor = UIColor.gray
self.view.addSubview(countrySearchController.searchBar)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func keyboardWillShow(aNotification: NSNotification) {
        
        let userinfo: NSDictionary = aNotification.userInfo! as NSDictionary
        
        let nsValue = userinfo.object(forKey: UIKeyboardFrameEndUserInfoKey)
        
        let keyboardRec = (nsValue as AnyObject).cgRectValue
        
        let height = keyboardRec?.size.height
        
        self.keyHeight = height!
        
        print("self.keyHeight: \(self.keyHeight)")
        
        
        UIView.animate(withDuration: 0.05, animations: {
            
            var frame = self.view.frame
            print(frame.origin.y)
            frame.origin.y = -self.keyHeight
            
            self.view.frame = frame
            
        }, completion: nil)
        
    }
    
    
    
    //键盘隐藏时恢复
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            var frame = self.view.frame
            
            frame.origin.y = 0
            
            self.view.frame = frame
            
        }, completion: nil)
        
        return true
        
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
extension GoodViewController: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
//        self.searchArray = self.schoolArray.filter { (school) -> Bool in
//            return school.contains(searchController.searchBar.text!)
//        }
        print("dfdfdfdfdfdfdfd..........")
    }
}

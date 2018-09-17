//
//  ViewController.swift
//  hangge_1342
//
//  Created by hangge on 2016/11/21.
//  Copyright © 2016年 hangge. All rights reserved.
//

import UIKit

class SystemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet var firstTableView: UITableView!
    var tableView: UITableView?
    let identify: String = "NotifyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        setNavBarTitle(view: self, title: "系统设置")
        self.view.backgroundColor = Specs.color.white
        
        //创建一个重用的单元格
        //        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        self.tableView?.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: identify)
        //        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
//        print("didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        
        print("我是第 \(indexPath.row) 个Cell")
        let cell: SwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: identify) as! SwitchTableViewCell
        cell.SwitchLabel.text = "我是第 \(indexPath.row) 个Cell"
        cell.SwitchWidget.isOn = true
        cell.accessoryType = .none
        return cell
    }
    
    
}

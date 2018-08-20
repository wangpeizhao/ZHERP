//
//  HomeChartsViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/20.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import Charts

class HomeChartsViewController: UIViewController {
    
    //折线图
    var chartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    func _setup() {
//        self.view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100))
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 80)
        self.view.addSubview(chartView)
        
        //生成20条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<14 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "") // 图例1
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
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

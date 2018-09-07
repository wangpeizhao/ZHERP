//
//  StatisticChartsViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/7.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import Charts

class StatisticChartsViewController: UIViewController {

    var ChartViewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    func _setup() {
        //折线图
        var chartView: LineChartView!
        //创建折线图组件对象
        chartView = LineChartView()
        //折线图背景色
        chartView.backgroundColor = Specs.color.gray
        chartView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: self.ChartViewHeight)
        chartView.chartDescription?.text = ""
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = true
        chartView.rightAxis.enabled = true
        //        chartView.leftAxis.spaceTop = 0.4
        //        chartView.leftAxis.spaceBottom = 0.4
        chartView.leftAxis.drawGridLinesEnabled = false //不绘制网格线
        chartView.xAxis.enabled = true
        chartView.xAxis.labelTextColor = UIColor(hex: 0x1a263a) //刻度文字颜色
        chartView.xAxis.drawAxisLineEnabled = false //不显示X轴
        
        chartView.xAxis.gridColor = UIColor(hex: 0x273347) //x轴对应网格线的颜色
        chartView.xAxis.gridLineWidth = 1 //x轴对应网格线的大小
        self.view.addSubview(chartView)
        
        //生成20条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<30 {
            let y = arc4random() % 100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "") // 图例1
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
        
        chartDataSet.mode = .horizontalBezier  //贝塞尔曲线
        
        chartDataSet.drawCirclesEnabled = false //不绘制转折点
        chartDataSet.drawValuesEnabled = false //不绘制拐点上的文字
        //开启填充色绘制
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillColor = UIColor(hex: 0x233a56)  //设置填充色
        chartDataSet.fillAlpha = 1 //设置填充色透明度
        //折线线条颜色
        chartDataSet.colors = [UIColor(hex: 0x25283a)]

        chartDataSet.circleColors = [UIColor(hex: 0x495b75)]  //外圆颜色
        chartDataSet.drawCircleHoleEnabled = false  //不绘制转折点内圆
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

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
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 70)
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    func _setup() {
        //创建折线图组件对象
        chartView = LineChartView()
        //折线图背景色
        chartView.backgroundColor = UIColor(hex: 0x1a263a)
        chartView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 70)
        chartView.chartDescription?.text = ""
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
//        chartView.leftAxis.spaceTop = 0.4
//        chartView.leftAxis.spaceBottom = 0.4
        chartView.leftAxis.drawGridLinesEnabled = false //不绘制网格线
        chartView.xAxis.enabled = false
        chartView.xAxis.labelTextColor = UIColor(hex: 0x1a263a) //刻度文字颜色
        chartView.xAxis.drawAxisLineEnabled = false //不显示X轴
        
        chartView.xAxis.gridColor = UIColor(hex: 0x273347) //x轴对应网格线的颜色
        chartView.xAxis.gridLineWidth = 2 //x轴对应网格线的大小
        self.view.addSubview(chartView)
        
        let showTodayBillBtn = UIButton(frame: CGRect(x: 35, y: 25, width: 90, height: 28))
        showTodayBillBtn.setTitle("查看今日流水", for: .normal)
        showTodayBillBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        showTodayBillBtn.setTitleColor(Specs.color.white, for: .normal)
        showTodayBillBtn.layer.cornerRadius = 10.0
        showTodayBillBtn.backgroundColor = UIColor(hex: 0x5faaff)
        showTodayBillBtn.addTarget(self, action: #selector(showTodayBill), for: .touchUpInside)
        self.view.addSubview(showTodayBillBtn)
        
        //生成20条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<15 {
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
        
        chartDataSet.drawCirclesEnabled = true //不绘制转折点
        chartDataSet.drawValuesEnabled = false //不绘制拐点上的文字
        //开启填充色绘制
        chartDataSet.drawFilledEnabled = true
        //渐变颜色数组
        let gradientColors = [UIColor(hex: 0x192130).cgColor, UIColor(hex: 0x233a56).cgColor] as CFArray
        //每组颜色所在位置（范围0~1)
        let colorLocations:[CGFloat] = [1.0, 0.0]
        //生成渐变色
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        //将渐变色作为填充对象s
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        //折线线条颜色
        chartDataSet.colors = [UIColor(hex: 0x273347)]
        
//        chartDataSet.lineWidth = 1.75
//        chartDataSet.circleRadius = 5.0
//        chartDataSet.circleHoleRadius = 2.5
//        chartDataSet.setColor(.white)
//        chartDataSet.setCircleColor(.white)
//        chartDataSet.highlightColor = .white
//        chartDataSet.drawValuesEnabled = false
        
        chartDataSet.circleColors = [UIColor(hex: 0x495b75)]  //外圆颜色
        chartDataSet.drawCircleHoleEnabled = false  //不绘制转折点内圆
//        chartDataSet.circleHoleColor = .red  //内圆颜色
//        chartDataSet.circleHoleRadius = 2 //内圆半径
        chartDataSet.circleRadius = 2 //外圆半径
    }
    
    @objc func showTodayBill() {
        let _target = OrderTodayBillViewController()
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: true)
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

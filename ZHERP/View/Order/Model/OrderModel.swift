//
//  OrderModel.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/27.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import Foundation

class OrderModel: NSObject {
    var orderId: String
    var orderTime: String
    var orderStatus: String
    var orderTotal: String
    var orderCoupon: String
    var orderAmount: String
    var orderQuantity: String
    var orderEmployee: String
    var receiver: String
    var receiverPhone: String
    var receiverRegion: String
    var receiverDetail: String
    var expressCompany: String
    var expressNumber: String
    var expressNote: String
    var expressEmployee: String
    var expressDatetime: String
    
    init(orderId: String, orderTime: String, orderStatus: String, orderTotal: String, orderCoupon: String, orderAmount: String, orderQuantity: String, orderEmployee: String, receiver: String, receiverPhone: String, receiverRegion: String, receiverDetail: String, expressCompany: String, expressNumber: String, expressNote: String, expressEmployee: String, expressDatetime: String) {
        self.orderId = orderId
        self.orderTime = orderTime
        self.orderStatus = orderStatus
        self.orderTotal = orderTotal
        self.orderCoupon = orderCoupon
        self.orderAmount = orderAmount
        self.orderQuantity = orderQuantity
        self.orderEmployee = orderEmployee
        self.receiver = receiver
        self.receiverPhone = receiverPhone
        self.receiverRegion = receiverRegion
        self.receiverDetail = receiverDetail
        self.expressCompany = expressCompany
        self.expressNumber = expressNumber
        self.expressNote = expressNote
        self.expressEmployee = expressEmployee
        self.expressDatetime = expressDatetime
    }
}

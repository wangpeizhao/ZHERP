//
//  HAllocatingModel.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation

class HAllocatingModel: NSObject {
    var id: Int
    var orderId: String
    var sn: String
    var name: String
    var warehouse: String
    var wId: Int
    var transferred: String
    var quantity: String
    var outWarehouse: String
    var inWarehouse: String
    var employee: String
    var datetime: Date
    
    init(id: Int, orderId: String, sn: String, name: String, warehouse: String, wId: Int, transferred: String, quantity: String, outWarehouse: String, inWarehouse: String, employee: String, datetime: Date) {
        self.id = id
        self.orderId = orderId
        self.sn = sn
        self.name = name
        self.warehouse = warehouse
        self.wId = wId
        self.transferred = transferred
        self.quantity = quantity
        self.outWarehouse = outWarehouse
        self.inWarehouse = inWarehouse
        self.employee = employee
        self.datetime = datetime
    }
}

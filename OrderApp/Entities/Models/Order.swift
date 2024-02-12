//
//  Order.swift
//  OrderApp
//
//  Created by Artyom on 12.02.24.
//

import Foundation

class Order {
    
    let id: String
    let clientId: String
    let productId: String
    let orderDate: String
    
    init(id: String, clientId: String, productId: String, orderDate: String) {
        self.id = id
        self.clientId = clientId
        self.productId = productId
        self.orderDate = orderDate
    }
}

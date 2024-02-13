//
//  Order.swift
//  OrderApp
//
//  Created by Artyom on 12.02.24.
//

import Foundation

class Order {
    
    let id: String
    let clientEmail: String
    let clientName: String
    let clientId: String
    let productId: String
    let orderDateSTR: String
    
    init(id: String, clientEmail: String, clientName: String, clientId: String, productId: String, orderDateSTR: String) {
        self.id = id
        self.clientEmail = clientEmail
        self.clientName = clientName
        self.clientId = clientId
        self.productId = productId
        self.orderDateSTR = orderDateSTR
    }
}

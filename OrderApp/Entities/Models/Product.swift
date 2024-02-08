//
//  Product.swift
//  OrderApp
//
//  Created by Artyom on 8.02.24.
//

import Foundation

class Product {
    
    let id: String
    let name: String
    let description: String
    let photoURL: String
    let price: Double
    
    init(id: String, name: String, description: String, photoURL: String, price: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.photoURL = photoURL
        self.price = price
    }
}

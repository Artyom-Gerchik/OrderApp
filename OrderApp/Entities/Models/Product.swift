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
    
    init?(dict: [String : Any], id: String) {
        self.id = id
        guard let name = dict["name"] as? String else { return nil }
        self.name = name
        guard let description = dict["description"] as? String else { return nil }
        self.description = description
        guard let photoURL = dict["photoURL"] as? String else { return nil }
        self.photoURL = photoURL
        guard let price = dict["price"] as? Double else { return nil }
        self.price = price
    }
}

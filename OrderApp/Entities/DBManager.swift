//
//  DBManager.swift
//  OrderApp
//
//  Created by Artyom on 8.02.24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class DBManager {
    
    let db = Firestore.firestore()
    
    func getGoods() async -> Array<Product>{
            
        var goods = [Product]()
        
        do {
          let querySnapshot = try await db.collection("goods").getDocuments()
          for product in querySnapshot.documents {
              goods.append(Product(id: String(product.documentID),
                                   name: product.data()["name"] as! String,
                                   description: product.data()["description"] as! String,
                                   photoURL: product.data()["photoURL"] as! String,
                                   price: product.data()["price"] as! Double))
            //print("\(product.documentID) => \(product.data())") // usage - document.data()["name"]
          }
        } catch {
          print("Error getting documents: \(error)")
        }
        return goods
    }
}

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
    
    let remoteDB = Firestore.firestore()
    
    func getGoods() async -> Array<Product>{
        
        var goods = [Product]()
        
        do {
            let querySnapshot = try await remoteDB.collection("goods").getDocuments()
            goods = querySnapshot.documents.compactMap { product in
                return Product(dict: product.data(), id: product.documentID)
            }
        } catch {
            print("Error getting documents: \(error)")
        }
        return goods
    }
    
    func createOrder(order: Order) {
        let ordersRef = remoteDB.collection("orders")
        
        ordersRef.document(order.id).setData([
            "clientEmail": order.clientEmail,
            "clientName": order.clientName,
            "clientId": order.clientId,
            "productId": order.productId,
            "orderDate": order.orderDateSTR
        ])
    }
    
    func saveImageLocally(image: UIImage, hashURL: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(hashURL).png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImageLocally(hashURL: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(hashURL).path)
        }
        return nil
    }
    
}

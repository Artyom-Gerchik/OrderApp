//
//  Extensions.swift
//  OrderApp
//
//  Created by Artyom on 9.02.24.
//

import Foundation
import UIKit

extension UIImageView{
    func imageFrom(url:URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data:data){
                    DispatchQueue.main.async{
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - TableView Delegates

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        cell.bindCellName(to: goods[indexPath.item].name)
        cell.bindCellDescription(to: goods[indexPath.item].description)
        cell.bindCellImageURL(to: goods[indexPath.item].photoURL)
        cell.bindCellProductId(to: goods[indexPath.item].id)
        
        cell.buyButtonAction = { [unowned self] in
            let vc = DetailsViewController()
            vc.productToOrder = Product(id: goods[indexPath.item].id, name: goods[indexPath.item].name, description: goods[indexPath.item].description, photoURL: goods[indexPath.item].photoURL, price: goods[indexPath.item].price)
            self.navigationController?.pushViewController(vc,animated:true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(goods.count != 0){
            //print("I AM HERE")
        }
        return goods.count
    }
}

//
//  Extensions.swift
//  OrderApp
//
//  Created by Artyom on 9.02.24.
//

import Foundation
import UIKit
import MessageUI

extension UIImageView{
    
    static let downloadSerialQueue = DispatchQueue(label: "MyQueue")
    
    func imageFrom(url: URL, completion: @escaping (UIImage) -> ()) {
        let urlString = String(describing: url)
        let urlStringHash = String(Encoder().strHash(urlString))
        
        UIImageView.downloadSerialQueue.async {
            if let image = DBManager().getSavedImageLocally(hashURL: urlStringHash) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data:data){
                        if DBManager().saveImageLocally(image: image, hashURL: urlStringHash) {
                            DispatchQueue.main.async {
                                completion(image)
                            }
                            print("SAVED IMAGE! \(urlStringHash)")
                        }else {
                            print("FAILURED WHILE SAVING IMAGE")
                        }
                    }
                }
            }
        }
    }
}

extension DetailsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension String {
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: self.count))
        
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - TableView Delegates

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.productToOrder = Product(id: goods[indexPath.item].id, name: goods[indexPath.item].name, description: goods[indexPath.item].description, photoURL: goods[indexPath.item].photoURL, price: goods[indexPath.item].price)
        self.navigationController?.pushViewController(vc,animated:true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        cell.bindCellName(to: goods[indexPath.item].name)
        cell.bindCellDescription(to: goods[indexPath.item].description)
        cell.bindCellImageURL(to: goods[indexPath.item].photoURL)
        cell.bindCellProductId(to: goods[indexPath.item].id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(goods.count != 0){
            // here you can stop the spinner, to tell that download is completed
        }
        return goods.count
    }
}

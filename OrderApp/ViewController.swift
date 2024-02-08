//
//  ViewController.swift
//  OrderApp
//
//  Created by Artyom on 7.02.24.
//

import UIKit


class ViewController: UIViewController {

    // MARK: - Properties
    
    var goods = [Product]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        view.separatorStyle = .none
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
        //group.enter()
        
       // DispatchQueue.global(qos: .default).async {
            // Network calls or some other async task
            Task {
                self.goods = await DBManager().getGoods()
                print("HELLO")
            }
         //   self.group.leave()
        //}
        
        //group.wait()
        
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                    ])
    }
    
    
}

// MARK: - TableView Delegates

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.bindCellName(to: goods[indexPath.item].name)
        cell.bindCellDescription(to: goods[indexPath.item].description)
        cell.bindCellImageURL(to: goods[indexPath.item].photoURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(goods.count != 0){
            print("I AM HERE")
        }
        return goods.count
    }
    
}


//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewDataSource.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
//        
//        if let cell = cell as? CustomTableViewCell {
//            cell.configureWith(number: tableViewDataSource[indexPath.row])
//        }
//        
//        return cell
//    }
//}
//
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//    }
//}

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
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        Task {
            self.goods = await DBManager().getGoods()
        }
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

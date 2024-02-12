//
//  OrderViewController.swift
//  OrderApp
//
//  Created by Artyom on 10.02.24.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var productToOrder: Product?
    
    @objc
    func proceedButtonTapped(_ sender: UIButton){
        let vc = OrderViewController()
        vc.productToOrder = productToOrder
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Views
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = productToOrder?.name
        return label
    }()
    
    private lazy var descrtiptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = productToOrder?.description
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.imageFrom(url: URL(string: productToOrder!.photoURL)!)
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Price: " + String(productToOrder!.price)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var proccedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(proceedButtonTapped(_:)), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Proceed", for: .normal)
        return button
    }()
    
    private lazy var VStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually // Setting the distribution to fill based on the content
        return stack
    }()
    
    private lazy var HStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually // Setting the distribution to fill based on the content
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        VStack.addArrangedSubview(nameLabel)
        VStack.addArrangedSubview(image)
        VStack.addArrangedSubview(descrtiptionLabel)
        
        HStack.addArrangedSubview(priceLabel)
        HStack.addArrangedSubview(proccedButton)
        
        VStack.addArrangedSubview(HStack)
        
        view.addSubview(VStack)
        setupUI()
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        
        HStack.setCustomSpacing(10, after: priceLabel)
        
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: view.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            VStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            VStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            image.heightAnchor.constraint(equalToConstant: view.frame.width - 32),
        ])
    }
}

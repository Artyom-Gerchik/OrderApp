//
//  OrderViewController.swift
//  OrderApp
//
//  Created by Artyom on 11.02.24.
//

import Foundation
import UIKit

class OrderViewController: UIViewController {
    
    // MARK: - Properties
    
    var productToOrder: Product?
    
    @objc
    func buyButtonTapped(_ sender: UIButton){
        //let vc = ViewController()
        //self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
        print(nameTextField.text!)
        
        let alert = UIAlertController(title: "Ordered!", message: "Subscribed to \(youtuber)", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okAction)
                
          self.present(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Views
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Name: "
        label.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.textAlignment = .center
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 10
        return nameTextField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Email: "
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.textAlignment = .center
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 10
        return emailTextField
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Buy", for: .normal)
        return button
    }()
    
    private lazy var VStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually // Setting the distribution to fill based on the content
        return stack
    }()
    
    private lazy var HStackForName: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually // Setting the distribution to fill based on the content
        return stack
    }()
    
    private lazy var HStackForEmail: UIStackView = {
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
        
        HStackForName.addArrangedSubview(nameLabel)
        HStackForName.addArrangedSubview(nameTextField)
        
        VStack.addArrangedSubview(HStackForName)
        
        HStackForEmail.addArrangedSubview(emailLabel)
        HStackForEmail.addArrangedSubview(emailTextField)
        
        VStack.addArrangedSubview(HStackForEmail)
        VStack.addArrangedSubview(buyButton)
        
        view.addSubview(VStack)
        setupUI()
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        
        
        
        VStack.setCustomSpacing(10, after: HStackForName)
        VStack.setCustomSpacing(50, after: HStackForEmail)
        //
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: view.topAnchor),
            VStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            VStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            VStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //image.heightAnchor.constraint(equalToConstant: view.frame.width - 32),
        ])
    }
    
}

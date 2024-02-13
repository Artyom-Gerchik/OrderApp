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
        
        if emailTextField.text?.isEmail == true {
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d / MMM / YYYY, HH:mm:ss"
            
            let order = Order(id: UUID().uuidString, clientEmail: emailTextField.text!, clientName: nameTextField.text!, clientId: UUID().uuidString, productId: productToOrder!.id, orderDateSTR: dateFormatter.string(from: date))
            
            DBManager().createOrder(order: order)
            
            let alert = UIAlertController(title: "Ordered!", message: "Order number is: \(order.id)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Error!", message: "Wrong email!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Views
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Name: "
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.textAlignment = .center
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 10
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
        return nameTextField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
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
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        
        navigationItem.title = "Order details"
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(buyButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -24),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -24),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.bottomAnchor.constraint(lessThanOrEqualTo: buyButton.topAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buyButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

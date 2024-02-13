//
//  OrderViewController.swift
//  OrderApp
//
//  Created by Artyom on 10.02.24.
//

import Foundation
import UIKit
import MessageUI

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var productToOrder: Product?
    
    @objc
    private func proceedButtonTapped(_ sender: UIButton){
        let vc = OrderViewController()
        vc.productToOrder = productToOrder
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func shareButtonTapped(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let messageBody: String = "<p>Hey!<br><br>Here is <b>\(productToOrder!.name)</b>, only for <b>\( productToOrder!.price)</b>!<br><br>Described as: \(productToOrder!.description)<br><br>Take a look: </p>"
            let messageSubject: String = "Look what i found!"
            let urlStringHash = String(Encoder().strHash(productToOrder!.photoURL))
            
            
            let mail = MFMailComposeViewController()
            mail.addAttachmentData((DBManager().getSavedImageLocally(hashURL: urlStringHash)?.pngData())!,
                                   mimeType: "image/png",
                                   fileName: "\(urlStringHash).png")
            mail.mailComposeDelegate = self
            mail.setMessageBody(messageBody, isHTML: true)
            mail.setSubject(messageSubject)
            present(mail, animated: true)
        } else {
            print("You can handle the method if your device cannot send Email. For example, this is not available for the simulator.")
        }
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
        imageView.imageFrom(url: URL(string: productToOrder!.photoURL)!) { [weak imageView] image in
            imageView?.image = image
        }
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
    
    private lazy var shareButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(shareButtonTapped(_:)))
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        
        navigationItem.rightBarButtonItem = shareButton
        navigationItem.title = productToOrder?.name
        
        view.addSubview(image)
        view.addSubview(descrtiptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(proccedButton)
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            image.heightAnchor.constraint(equalToConstant: 300),
            image.bottomAnchor.constraint(equalTo: descrtiptionLabel.topAnchor, constant: -24),
            
            descrtiptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descrtiptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descrtiptionLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -24),
            
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: proccedButton.topAnchor, constant: 20),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            
            proccedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            proccedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            proccedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            proccedButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}

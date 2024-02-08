//
//  CustomTableViewCell.swift
//  OrderApp
//
//  Created by Artyom on 8.02.24.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    //let label = UILabel()
    
    
    // MARK: - Views
    
    private lazy var cellBackground: UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = 10
        background.backgroundColor = .systemPink
        return background
    }()
    
    private lazy var cellNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var cellDescrtiptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var cellButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for:.touchUpInside)
        return button
    }()
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return imageView
    }()
    
    // UIKit HStack equivalent
    lazy var contentHStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually // Setting the distribution to fill based on the content
        return stack
    }()
    
    lazy var nameAndDescriptionVStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally // Setting the distribution to fill based on the content
        return stack
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        
        
        nameAndDescriptionVStack.addArrangedSubview(cellNameLabel)
        nameAndDescriptionVStack.addArrangedSubview(cellDescrtiptionLabel)
        
        contentHStack.addArrangedSubview(cellImage)
        contentHStack.addArrangedSubview(nameAndDescriptionVStack)
        contentHStack.addArrangedSubview(cellButton)
        
        cellBackground.addSubview(contentHStack)
        
        //contentView.backgroundColor = .systemMint
        contentView.addSubview(cellBackground)
        
        NSLayoutConstraint.activate([
            
            contentView.heightAnchor.constraint(equalToConstant: 100),
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            contentHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            
//            cellButton.heightAnchor.constraint(equalToConstant: 100),
//            cellButton.widthAnchor.constraint(equalToConstant: 50),
//            cellButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            cellButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            
        ])
    }
    
    // MARK: - Binding
    
    func bindCellName(to name: String) {
        cellNameLabel.text = name
    }
    
    func bindCellDescription(to description: String) {
        cellDescrtiptionLabel.text = description
    }
    
    func bindCellImageURL(to URLStr: String) {
        cellImage.imageFrom(url: URL(string: URLStr)!)
    }
    
    @objc
    func buttonTapped() {
        print(cellNameLabel.text!)
    }
    
    //    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //        super.init(style: style, reuseIdentifier: reuseIdentifier)
    //        self.contentView.addSubview(label)
    //
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    //        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    //        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    //        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    //    func configureWith(number: Int) {
    //        label.text = String(number)
    //    }
    
}

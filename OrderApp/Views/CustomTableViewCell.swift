//
//  CustomTableViewCell.swift
//  OrderApp
//
//  Created by Artyom on 8.02.24.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var cellProductId: String?
    var cellPhotoURL: String?
    
    // MARK: - Views
    
    private lazy var cellBackground: UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = 10
        background.backgroundColor = .lightGray
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
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    // UIKit HStack equivalent
    lazy var contentHStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally // Setting the distribution to fill based on the content
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellPhotoURL = nil
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        
        nameAndDescriptionVStack.addArrangedSubview(cellNameLabel)
        nameAndDescriptionVStack.addArrangedSubview(cellDescrtiptionLabel)
        
        contentHStack.addArrangedSubview(cellImage)
        contentHStack.addArrangedSubview(nameAndDescriptionVStack)
        
        contentHStack.setCustomSpacing(10, after: cellImage)
        contentHStack.setCustomSpacing(10, after: nameAndDescriptionVStack)
        
        cellBackground.addSubview(contentHStack)
        contentView.addSubview(cellBackground)
        
        NSLayoutConstraint.activate([
            
            contentView.heightAnchor.constraint(equalToConstant: 100),
            cellImage.widthAnchor.constraint(equalToConstant: 100),
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            contentHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    // MARK: - Binding
    
    func bindCellName(to name: String) {
        cellNameLabel.text = name
    }
    
    func bindCellDescription(to description: String) {
        cellDescrtiptionLabel.text = description
    }
    
    func bindCellImageURL(to URLStr: String) { //add goods and prints
        let url = URLStr
        self.cellPhotoURL = URLStr
        cellImage.imageFrom(url: URL(string: URLStr)!) { [weak self] image in
            if url == self?.cellPhotoURL {
                self?.cellImage.image = image
            }
        }
    }
    
    func bindCellProductId(to productId: String) {
        cellProductId = productId
    }
}

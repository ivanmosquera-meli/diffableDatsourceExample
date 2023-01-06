//
//  ProductCollectionCell.swift
//  diffableDataSourceExample
//
//  Created by Ivan Dario Mosquera Trivino on 5/01/23.
//

import Foundation
import UIKit

class ProductCollectionCell: UICollectionViewCell {
    private weak var productName: UILabel!
    private weak var productPrice: UILabel!
    private weak var productStatus: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(model: ProductModel) {
        self.productName.text = model.name
        self.productPrice.text = model.price
        self.productStatus.text = model.status
    }
    
    func setupUI() {
        let productName = UILabel()
        let productPrice = UILabel()
        let productStatus = UILabel()
        productName.textColor = .black
        productName.font = UIFont(name: "system", size: 18.0)
        productPrice.textColor = .black
        productPrice.font = UIFont(name: "system", size: 18.0)
        productStatus.textColor = .black
        productStatus.font = UIFont(name: "system", size: 18.0)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(productStatus)
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        productName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.0).isActive = true
        
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        productPrice.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        productPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        productPrice.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20.0).isActive = true
        
        productStatus.translatesAutoresizingMaskIntoConstraints = false
        productStatus.topAnchor.constraint(equalTo: productName.bottomAnchor).isActive = true
        productStatus.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.0).isActive = true
        productStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        productStatus.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        self.productName = productName
        self.productPrice = productPrice
        self.productStatus = productStatus
    }
}

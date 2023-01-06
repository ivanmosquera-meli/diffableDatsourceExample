//
//  ProductModel.swift
//  diffableDataSourceExample
//
//  Created by Ivan Dario Mosquera Trivino on 5/01/23.
//

import Foundation

class ProductModel: Hashable {
    let id: Int
    var name: String
    var price: String
    var status: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    init(id: Int, name: String, price: String, status: String) {
        self.id = id
        self.name = name
        self.price = price
        self.status = status
    }
    
}

extension ProductModel: Equatable {
    static func == (lhs:ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}

enum ProductsSection: Hashable {
    case main
}

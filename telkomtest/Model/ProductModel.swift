//
//  ProductModel.swift
//  telkomtest
//
//  Created by Muhammad Firman Nur on 05/10/22.
//

import Foundation

struct ProductModel: Decodable {
    let productName: String
    let productLogo: String
    let colorTheme: String
}

struct ProductResponse: Decodable {
    let data: [ProductModel]?
    let message: String
    let status: Int
}

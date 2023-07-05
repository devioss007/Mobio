//
//  MainProductsModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 04/07/23.
//

import Foundation

struct MainProductsModel: Codable {
    let message: String
    let data: [Data]
}

struct Data: Codable {
    let title: String
    let products: [Products]
}

struct Products: Codable {
    let productsss: [Productsss]
    let photo: Photo
    let rate: [Rate]
}

struct Productsss: Codable {
    let name: String
    let old_price: String
    let price: String
}

struct Rate: Codable {
    let rating: Double
}

struct Photo: Codable {
    let id: Int
    let file_name: String
}
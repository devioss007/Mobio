//
//  ProductModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 10/07/23.
//

import Foundation

struct ProductModel: Codable {
    let message: String
    let data: Data
    
    struct Data: Codable {
        let name: String
        let description: String?
        let old_price: String
        let price: String
        let photos: [Photos]
        
        
    }
}

struct Photos: Codable,Hashable {
    let id: Int
    let file_name: String
}

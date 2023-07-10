//
//  CategoryProductsModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 10/07/23.
//

import Foundation

struct CategoryProductsModel: Codable {
    let message: String
    let data: Data
    
    struct Data: Codable {
        let data: [Data]
        
        struct Data: Codable {
            let productss: Productss
            let photo: Photo
            let rate: [Rate]
            
            struct Productss: Codable {
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
        }
    }
}

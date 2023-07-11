//
//  SearchModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 11/07/23.
//

import Foundation


struct SearchModel: Codable {
    let message: String
    let data: Data
    
    struct Data: Codable {
        let current_page: Int
        let data: [Data]

        struct Data: Codable {
            let id: Int
            let name: String
            let price: String
            let photos: [Photos]?
        }
        
        struct Photos: Codable {
            let id: Int
            let file_name: String
        }
    }
}

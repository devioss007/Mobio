//
//  HomeScreenModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 27/06/23.
//

import Foundation

struct HomeScreenModel: Codable {
    let category: HomeScreenResultsModel
}

struct HomeScreenResultsModel: Codable {
    let data: [HomeScreenItems]
}

struct HomeScreenItems: Codable, Hashable, Identifiable
//, Hashable
//, Identifiable
{
//    var id: Int
//    let name: String
//
//    init(id: Int, name: String) {
//        self.id = 0
//        self.name = name
//    }
    
    let id: Int
    let name: String
    let photo_cat: PhotoCat?
}

struct PhotoCat: Codable, Hashable, Identifiable {
    let id: Int
    let file_name: String
}

//
//  CategoryDetailViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 10/07/23.
//

import Foundation

final class CategoryDetailViewModel: ObservableObject {
    private let service = NetworkManager()

    @Published var data = CategoryProductsModel(message: "", data: CategoryProductsModel.Data(data: []))
    
    func getItems(id: Int) {
        service.getCategoryProducts(id: id) { response in
            switch response {
            case .success(let data):
                self.data = data
//                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func calculateRate(_ items: [CategoryProductsModel.Data.Data.Rate]) -> Double {
        if items.isEmpty {
            return 0.0
        }
        var sum: Double = 0
        var avg: Double
        for i in items {
            sum += i.rating
        }
        avg = sum / Double(items.count)
        return avg
    }
}

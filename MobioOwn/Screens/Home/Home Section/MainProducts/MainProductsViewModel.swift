//
//  MainProductsViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 04/07/23.
//

import Foundation

final class MainProductsViewModel: ObservableObject {
    private let service = NetworkManager()
    
    @Published var data = MainProductsModel(message: "", data: [])
    
    func getItems() {
        service.getMainProducts { response in
            switch response {
            case .success(let data):
                self.data = data
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func calculateRate(_ items: [Rate]) -> Double {
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

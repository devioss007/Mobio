//
//  DetailProductViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 10/07/23.
//

import Foundation

final class DetailProductViewModel: ObservableObject {
    private let service = NetworkManager()
    @Published var data = ProductModel(message: "", data: ProductModel.Data(name: "", description: "", old_price: "", price: "", photos: []))
    
    func getItem(id: Int) {
        service.getSingleProduct(id: id) { response in
            switch response {
            case .success(let response):
                self.data = response
                print(response.data.photos)
            case .failure(let error):
                print(error)
            }
        }
    }
}

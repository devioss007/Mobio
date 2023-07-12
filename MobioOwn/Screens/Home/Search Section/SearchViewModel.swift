//
//  SearchViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 11/07/23.
//

import Foundation

final class SearchViewModel: ObservableObject {
    private let service = NetworkManager()
    private var page: Int = 1
    private let count: Int = 100
    
    @Published var items: [SearchModel.Data.Data] = []

    func search(with text: String) {
        service.performSearch(text: text, page: page, count: count) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let response):
                self.items = response.data.data
            case .failure(let error):
                self.items = []
                print(error)
            }
        }
    }
}

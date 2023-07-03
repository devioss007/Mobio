//
//  HomeViewSectionViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 27/06/23.
//

import Foundation

final class HomeViewSectionViewModel: ObservableObject {
    private var page: Int = 0
    private var moreElementsExist = true
    let service = NetworkManager()
    
    @Published var items: [HomeScreenItems] = []
    @Published var showProgressView: Bool = false

    func getItems() {
        if moreElementsExist {
            page += 1
//            showProgressView = true
            print(page)
            service.getAllDataForHomeScreen(page: page) { resonse in
//                self.showProgressView = false
                switch resonse {
                case .success(let items):
                    self.items += items
                case .failure:
                    self.moreElementsExist = false
                    print("finish")
                }
            }
        }
    }
}

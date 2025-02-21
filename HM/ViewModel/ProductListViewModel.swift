//
//  ProductListViewModel.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import UIKit

/// Type serving logic for `ProductListView`.
@MainActor
final class ProductListViewModel: ObservableObject {
    
    @Published
    private(set) var state: ProductListViewModel.State = .initial
    
    private(set) var products: [Product] = []
    private(set) var page: Pagination? = nil
    
    // DI
    private let searchKeyword: String
    private let touchPoint: String
    private let errorImage: UIImage
    private let paletteLimit: Int
    private let searchListProvider: any SearchListProvider
    private let imageProvider: any ImageProvider
    
    init(searchKeyword: String, touchPoint: String, errorImage: UIImage, paletteLimit: Int, searchListProvider: any SearchListProvider, imageProvider: any ImageProvider) {
        self.searchKeyword = searchKeyword
        self.touchPoint = touchPoint
        self.errorImage = errorImage
        self.paletteLimit = paletteLimit
        self.searchListProvider = searchListProvider
        self.imageProvider = imageProvider
    }
    
    func refresh() async {
        guard self.state != .refreshing else { return }
        
        self.state = .refreshing
        self.page = nil
        self.products = []
        
        Task(priority: .userInitiated) {
            do {
                let list = try await self.searchListProvider.getSearchListWithKeyword(self.searchKeyword, page: 1, touchPoint: self.touchPoint)
                self.products = list.products
                self.page = list.pagination
            } catch {
                self.state = .error
            }
            await MainActor.run { self.state = .idle }
        }
    }
    
    func fetchNextPage() async {
        guard self.state != .fetching else { return }
        
        self.state = .fetching
        
        Task(priority: .userInitiated) {
            do {
                let list = try await self.searchListProvider.getSearchListWithKeyword(self.searchKeyword, page: self.nextPageNumber(), touchPoint: self.touchPoint)
                self.products += list.products
                self.page = list.pagination
                self.state = .idle
            } catch {
                self.state = .idle
            }
            await MainActor.run { self.state = .idle }
        }
    }
    
    func makeViewModelForProduct(_ product: Product) -> ProductViewModel {
        ProductViewModel(
            product: product,
            imageProvider: self.imageProvider,
            paletteLimit: self.paletteLimit,
            errorImage: self.errorImage
        )
    }
}

private extension ProductListViewModel {
    
    func nextPageNumber() -> Int {
       guard let page else { return 1 }
       
       return page.currentPage + 1
   }
}

extension ProductListViewModel {
    
    /// Type defining possible states of `ProductListViewModel` instance.
    enum State {
        
        /// Initial state for `ProductListViewModel` instance.
        case initial
        
        /// `ProductListViewModel` instance is presenting content.
        case idle
        
        /// `ProductListViewModel` instance is presenting error.
        case error
        
        /// `ProductListViewModel` instance is refreshing its content.
        case refreshing
        
        /// `ProductListViewModel` instance is fetching content.
        case fetching
    }
}

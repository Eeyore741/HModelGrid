//
//  ProductViewModel.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-10.
//

import UIKit

/// Type serving logic for `ProductViewModel`.
@MainActor
final class ProductViewModel: ObservableObject {
    
    @Published
    private(set) var state: ProductViewModel.State = .background
    
    private(set) var image: UIImage = UIImage()
    private(set) var brandName: String = String()
    private(set) var productName: String = String()
    private(set) var formattedPrice: String = String()
    private(set) var swatchList: [Swatch] = []
    private(set) var paletteColors: [UIColor] = []
    
    // DI
    private let product: Product
    private let imageProvider: any ImageProvider
    private let errorImage: UIImage
    let paletteLimit: Int
    
    init(product: Product, imageProvider: any ImageProvider, paletteLimit: Int, errorImage: UIImage) {
        self.product = product
        self.imageProvider = imageProvider
        self.paletteLimit = paletteLimit
        self.errorImage = errorImage
        
        self.brandName = self.product.brandName
        self.productName = self.product.productName
        self.formattedPrice = self.product.formattedPrice
        self.swatchList = self.product.swatches
        self.paletteColors = self.product.swatches.map { UIColor(hex: $0.colorCode) }
    }
    
    func fetchImage() async {
        guard self.state != .fetching else { return }
        guard let url = URL(string: product.modelImage) else { return self.image = self.errorImage}
        
        self.state = .fetching
        
        Task(priority: .userInitiated) {
            do {
                self.image = try await self.imageProvider.getImageWithURL(url)
            } catch {
                self.image = self.errorImage
            }
            await MainActor.run { self.state = .idle }
        }
    }
    
    func onDisappear() async {
        self.image = UIImage()
        self.state = .background
    }
    
    func onAppear() async {
        await self.fetchImage()
    }
}

extension ProductViewModel {
    
    /// Type defining possible states of `ProductViewModel` instance.
    enum State {
        
        /// `ProductViewModel` instance is presenting content.
        case idle
        
        /// `ProductViewModel` instance is presenting content.
        case fetching
        
        /// `ProductViewModel` instance is not visible.
        case background
    }
}

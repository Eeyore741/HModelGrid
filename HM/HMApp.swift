//
//  HMApp.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import SwiftUI

@main
struct HMApp: App {
    var body: some Scene {
        WindowGroup {
            let searchProvider = RemoteSearchListProvider()
            let imageProvider = RemoteImageProvider(
                imageScale: Configuration.imageScale,
                imageCacheCount: Configuration.imageCacheCount
            )
            let productListViewModel = ProductListViewModel(
                searchKeyword: Configuration.searchKeyword,
                touchPoint: Configuration.touchPoint,
                errorImage: UIImage(imageLiteralResourceName: Configuration.errorImageResourceName),
                paletteLimit: Configuration.paletteLimit,
                searchListProvider: searchProvider,
                imageProvider: imageProvider
            )
            ProductListView(viewModel: productListViewModel)
        }
    }
}

private extension HMApp {
    
    /// Type defines app behaviour configuration
    enum Configuration {
        
        /// Product search keyword.
        static let searchKeyword: String = "jeans"
        
        /// Platform.
        static let touchPoint: String = "ios"
        
        /// Number of product colors to display.
        static let paletteLimit: Int = 3
        
        /// Scale factor for product image.
        static let imageScale: CGFloat = 0.25
        
        /// Image cache size.
        static let imageCacheCount: Int = 6
        
        /// Title of assets image to disaply in case of error fetching product image.
        static let errorImageResourceName: String = "error"
    }
}

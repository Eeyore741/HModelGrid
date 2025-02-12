//
//  ProductViewModelTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class ProductViewModelTests: XCTestCase {
    
    func test() async throws {
        let product = Product(
            productId: "productId",
            productName: "productName",
            brandName: "brandName",
            modelImage: "modelImage",
            formattedPrice: "formattedPrice",
            swatches: []
        )
        let imageProvider = DemoImageProvider(mode: .success, delayInSeconds: 1)
        let sut = await ProductViewModel(product: product, imageProvider: imageProvider, paletteLimit: 3, errorImage: UIImage())
    }
}

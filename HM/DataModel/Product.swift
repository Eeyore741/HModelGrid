//
//  Product.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import Foundation

/// Type describing api product type.
struct Product {
    let id: UUID = UUID()
    let productId: String
    let productName: String
    let brandName: String
    let modelImage: String
    let formattedPrice: String
    let swatches: [Swatch]
}

extension Product: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case productId = "id"
        case productName
        case brandName
        case modelImage
        case prices
        case swatches
    }
    
    private struct Price: Decodable {
        let formattedPrice: String
    }
    
    init(from decoder: any Decoder) throws {
        let containder = try decoder.container(keyedBy: Product.CodingKeys.self)
        
        self.productId = try containder.decode(String.self, forKey: .productId)
        self.productName = try containder.decode(String.self, forKey: .productName)
        self.brandName = try containder.decode(String.self, forKey: .brandName)
        self.modelImage = try containder.decode(String.self, forKey: .modelImage)
        self.swatches = try containder.decode([Swatch].self, forKey: .swatches)
        
        let prices = try containder.decode([Price].self, forKey: .prices)
        self.formattedPrice = prices.first?.formattedPrice ?? String()
    }
}

extension Product: Identifiable { }

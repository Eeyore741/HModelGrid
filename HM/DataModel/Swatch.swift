//
//  Swatch.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-11.
//

import Foundation

/// Type describing api product from different color perspectives type.
struct Swatch {
    let id: String
    let colorName: String
    let colorCode: String
}

extension Swatch: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "articleId"
        case colorName
        case colorCode
    }
}

extension Swatch: Identifiable { }

extension Swatch: Equatable { }

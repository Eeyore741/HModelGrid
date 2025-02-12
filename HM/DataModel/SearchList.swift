//
//  SearchList.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import Foundation

/// Type describing api search list type.
struct SearchList {
    let requestDateTime: String
    let pagination: Pagination
    let products: [Product]
}

extension SearchList: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case requestDateTime
        case pagination
        case searchHits
    }
    
    private struct SearchHits: Decodable {
        let productList: [Product]
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.requestDateTime = try container.decode(String.self, forKey: .requestDateTime)
        self.pagination = try container.decode(Pagination.self, forKey: .pagination)
        
        let searchHits = try container.decode(SearchHits.self, forKey: .searchHits)
        self.products = searchHits.productList
    }
}

//
//  Pagination.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import Foundation

/// Type describing api pagination type.
struct Pagination {
    let currentPage: Int
    let nextPageNum: Int
    let totalPages: Int
}

extension Pagination: Decodable { }

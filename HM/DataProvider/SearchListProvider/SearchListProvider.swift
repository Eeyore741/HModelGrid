//
//  SearchListProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import Foundation

/// Protocol describing requirements for type provifings `SearchList` type.
protocol SearchListProvider: Sendable {
    
    /// Request `SearchList` with provided parameters.
    /// - Parameters:
    ///   - keyword: Keyword defining content of result `SearchList` model.
    ///   - page: Page of result `SearchList`.
    ///   - touchPoint: Parameter defining current platform.
    /// - Returns: Instance of `SearchList` depending on input parameters.
    func getSearchListWithKeyword(_ keyword: String, page: Int, touchPoint: String) async throws -> SearchList
}

/// Type describes possible error cases of `SearchListProvider`.
enum SearchListProviderError: Error {
    
    /// Error trying to reach remote resource.
    case resourceUnreachable
    
    /// Error decoding `Data` into `SearchList` instance.
    case dataDecoding
}

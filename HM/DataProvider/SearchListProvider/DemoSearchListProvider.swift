//
//  DemoSearchListProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-10.
//

import Foundation

/// Demo type conforming to `SearchListProvider`, serving UI building/preview purposes.
actor DemoSearchListProvider {
    
    private static let bundledResourceName: String = "productList"
    private static let bundledResourceExtension: String = "json"
    
    var mode: DemoSearchListProvider.Mode
    var delayInSeconds: UInt64
    
    /// Initialize instance of `DemoSearchListProvider` with optional parameters.
    /// - Parameters:
    ///   - mode: Parameter defines behaviour of instance.
    ///   - getDelayInSeconds: Parameter defines data fetch delay.
    init(mode: DemoSearchListProvider.Mode = .success, getDelayInSeconds: UInt64 = 1) {
        self.mode = mode
        self.delayInSeconds = getDelayInSeconds
    }
}

/// `SearchListProvider` conforming extension.
extension DemoSearchListProvider: SearchListProvider {
    
    func getSearchListWithKeyword(_ query: String, page: Int, touchPoint: String) async throws -> SearchList {
        switch self.mode {
        case .success:
            guard let url = Bundle.main.url(forResource: Self.bundledResourceName, withExtension: Self.bundledResourceExtension) else {
                throw SearchListProviderError.resourceUnreachable
            }
            let data = try Data(contentsOf: url)
            let list = try JSONDecoder().decode(SearchList.self, from: data)
            
            try await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
            
            return list
        case .error(let error):
            try await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
            
            throw error
        }
    }
}

extension DemoSearchListProvider {
    
    /// Type defines `DemoSearchListProvider` behaviour.
    enum Mode {
        
        /// `DemoSearchListProvider` instance returns bundeled `SearchList` on request.
        case success
        
        /// `DemoSearchListProvider` throws error on `SearchList` request.
        case error(SearchListProviderError)
    }
}

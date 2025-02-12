//
//  RemoteSearchListProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-10.
//

import Foundation

/// Type conforming to `RemoteSearchListProvider`, utilizing remote data provider.
actor RemoteSearchListProvider {
    
    private let remoteDataProvider: RemoteDataProvider
    
    init() {
        self.remoteDataProvider = RemoteDataProvider()
    }
}

/// `SearchListProvider` conforming extension.
extension RemoteSearchListProvider: SearchListProvider {
    
    func getSearchListWithKeyword(_ keyword: String, page: Int, touchPoint: String) async throws -> SearchList {
        let url = try URLProvider.makeSearchRequestWithTouchPoint(touchPoint, keyword: keyword, page: page)
        let data = try await remoteDataProvider.getRemoteResourceWithUrl(url)
        let searchList = try JSONDecoder().decode(SearchList.self, from: data)
        
        return searchList
    }
}

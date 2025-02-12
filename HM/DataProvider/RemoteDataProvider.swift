//
//  RemoteDataProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import Foundation

/// Remote resources provider utilizing `URLSession` instance.
actor RemoteDataProvider {
    
    private let session: URLSession
    
    /// Initialize instance of `RemoteDataProvider` with optional parameters provided.
    /// - Parameter sessionConfiguration: Parameter defining internal `URLSession` behaviour.
    init(sessionConfiguration: URLSessionConfiguration = .ephemeral) {
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    /// Get instance of `Data` using remote `URL` parameter.
    /// - Parameter resourceUrl: Remote `URL` to fetch `Data` from.
    func getRemoteResourceWithUrl(_ resourceUrl: URL) async throws(RemoteDataProvider.Failure) -> Data {
        let request = URLRequest(url: resourceUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        do {
            let response = try await session.data(for: request)
            
            guard let httpUrlResponse = response.1 as? HTTPURLResponse else { throw RemoteDataProvider.Failure.nonHttpResponse }
            guard (200..<300).contains(httpUrlResponse.statusCode) else { throw RemoteDataProvider.Failure.response(code: httpUrlResponse.statusCode) }
            
            return response.0
        } catch {
            
            throw .session(error: error)
        }
    }
}

/// Type defines erorr cases of `RemoteDataProvider`.
extension RemoteDataProvider {
    
    enum Failure: Error {
        
        /// Request got non http response.
        case nonHttpResponse
        
        /// Request encountered session error.
        case session(error: Error)
        
        /// Request received failed response code.
        case response(code: Int)
    }
}

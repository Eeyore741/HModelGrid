//
//  URLProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import Foundation

/// Type providing `URL` make functionality for one given domain.
enum URLProvider { }

private extension URLProvider {
    
    /// Result `URL` scheme.
    enum Scheme: String {
        case https = "https"
    }
    
    /// Result `URL` base url.
    enum BaseUrl: String {
        case host = "api.hm.com"
    }
    
    /// Result `URL` path for resource.
    enum Path: String {
        case search = "/search-services/v1/sv_se/search/resultpage"
    }
    
    /// Result `URL` parameter to embed.
    enum Parameter: String {
        case touchPoint = "touchPoint"
        case query = "query"
        case page = "page"
    }
}

extension URLProvider {
    
    /// Return `URL` instance with given parameters
    /// - Parameters:
    ///   - touchPoint: Current platform.
    ///   - keyword: Search keyword.
    ///   - page: Page for response list.
    static func makeSearchRequestWithTouchPoint(_ touchPoint: String, keyword: String, page: Int) throws(URLProviderError) -> URL {
        var components = URLComponents()
        components.scheme = Scheme.https.rawValue
        components.host = BaseUrl.host.rawValue
        components.path = Path.search.rawValue
        components.queryItems = [
            URLQueryItem(name: Parameter.touchPoint.rawValue, value: touchPoint),
            URLQueryItem(name: Parameter.query.rawValue, value: keyword),
            URLQueryItem(name: Parameter.page.rawValue, value: String(page))
        ]
        
        guard let url = components.url else { throw URLProviderError.urlMake }
        
        return url
    }
}

/// Type describing possible error cases for `URLProvider` behaviour.
enum URLProviderError: Error {
    
    /// Error on building `URL` instance.
    case urlMake
}

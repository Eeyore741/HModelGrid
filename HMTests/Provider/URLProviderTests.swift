//
//  URLProviderTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class URLProviderTests: XCTestCase {
    
    func testMakeSearchRequestWithTouchPoint() throws {
        let sut = try URLProvider.makeSearchRequestWithTouchPoint("touchPoint", keyword: "keywork", page: 1)
        let url = URL(string: "https://api.hm.com/search-services/v1/sv_se/search/resultpage?touchPoint=touchPoint&query=keywork&page=1")!
        XCTAssertEqual(sut, url)
    }
}

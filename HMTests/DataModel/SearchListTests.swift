//
//  SearchListTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class SearchListTests: XCTestCase {
    
    func testDecodable() throws {
        let bundle = Bundle(for: DemoSearchListProvider.self)
        
        guard let url = bundle.url(forResource: "productList", withExtension: "json") else { fatalError() }
        
        let data = try Data(contentsOf: url)
        let sut = try JSONDecoder().decode(SearchList.self, from: data)
        
        XCTAssertEqual(sut.requestDateTime, "2025-02-10T14:37:57.709Z")
        XCTAssertEqual(sut.products.count, 36)
        XCTAssertEqual(sut.pagination.currentPage, 1)
        XCTAssertEqual(sut.pagination.nextPageNum, 2)
        XCTAssertEqual(sut.pagination.totalPages, 41)
    }
}

//
//  PaginationTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class PaginationTests: XCTestCase {
    
    func testInterface() throws {
        let sut = Pagination(currentPage: 0, nextPageNum: 1, totalPages: 3)
        XCTAssertEqual(sut.currentPage, 0)
        XCTAssertEqual(sut.nextPageNum, 1)
        XCTAssertEqual(sut.totalPages, 3)
    }
    
    func testDecodable() throws {
        let data = Data(Self.pageJson.utf8)
        let sut = try JSONDecoder().decode(Pagination.self, from: data)
        
        XCTAssertEqual(sut.currentPage, 5)
        XCTAssertEqual(sut.nextPageNum, 6)
        XCTAssertEqual(sut.totalPages, 41)
    }
    
    private static let pageJson: String =
    """
      {
        "currentPage": 5,
        "nextPageNum": 6,
        "totalPages": 41
      }
    """
}

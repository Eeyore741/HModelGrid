//
//  SwatchTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class SwatchTests: XCTestCase {
    
    func testInterface() throws {
        let sut = Swatch(id: "1", colorName: "Red", colorCode: "FF0000")
        XCTAssertEqual(sut.id, "1")
        XCTAssertEqual(sut.colorName, "Red")
        XCTAssertEqual(sut.colorCode, "FF0000")
    }
    
    func testDecodable() throws {
        let data = Data(Self.swatchJson.utf8)
        let sut = try JSONDecoder().decode(Swatch.self, from: data)
        
        XCTAssertEqual(sut.id, "1")
        XCTAssertEqual(sut.colorName, "Red")
        XCTAssertEqual(sut.colorCode, "FF0000")
    }
    
    private static let swatchJson: String =
    """
      {
        "articleId": "1",
        "colorName": "Red",
        "colorCode": "FF0000"
      }
    """
}

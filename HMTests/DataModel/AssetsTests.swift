//
//  Untitled.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class AssetsTests: XCTestCase {
    
    func testProductList() throws {
        let bundle = Bundle(for: DemoSearchListProvider.self)
        XCTAssertNotNil(bundle.url(forResource: "productList", withExtension: "json"))
    }
    
    func testErrorImage() throws {
        let bundle = Bundle(for: DemoSearchListProvider.self)
        XCTAssertNotNil(UIImage(named: "error", in: bundle, with: nil))
    }
    
    func testJeansImage() throws {
        let bundle = Bundle(for: DemoSearchListProvider.self)
        XCTAssertNotNil(UIImage(named: "demoJeans", in: bundle, with: nil))
    }
}

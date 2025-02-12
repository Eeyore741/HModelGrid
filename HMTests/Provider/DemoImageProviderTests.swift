//
//  DemoImageProviderTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class testDemoImageProviderTests: XCTestCase {
    
    func testInit() {
        XCTAssertNoThrow(DemoImageProvider())
    }
    
    func testGetImage() async throws {
        let sut = DemoImageProvider(mode: .success)
        let dummyURL = URL(string: "scheme://domain")!
        let image = try await sut.getImageWithURL(dummyURL)
        
        XCTAssertEqual(image.jpegData(compressionQuality: 1)?.count, 48660)
    }
    
    func testSuccessMode() async throws {
        let sut = DemoImageProvider(mode: .success)
        let dummyURL = URL(string: "scheme://domain")!
        _ = try await sut.getImageWithURL(dummyURL)
    }
    
    func testErrorMode() async throws {
        let sut = DemoImageProvider(mode: .error(ImageProviderError.dataDecoding))
        let dummyURL = URL(string: "scheme://domain")!
        
        do {
            _ = try await sut.getImageWithURL(dummyURL)
            XCTFail()
        } catch {
            XCTAssertTrue(error is ImageProviderError)
        }
    }
}

//
//  ProductTests.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-12.
//

import XCTest
@testable import HM

final class ProductTests: XCTestCase {
    
    func testInterface() throws {
        let swatches = [
            Swatch(id: "articleId", colorName: "Red", colorCode: "ff0000"),
            Swatch(id: "articleId", colorName: "Green", colorCode: "00ff00"),
            Swatch(id: "articleId", colorName: "Blue", colorCode: "0000ff"),
            Swatch(id: "articleId", colorName: "Black", colorCode: "000000")
        ]
        
        let sut = Product(
            productId: "1",
            productName: "productName",
            brandName: "brandName",
            modelImage: "modelImage",
            formattedPrice: "99.99 kr",
            swatches: swatches
        )
        
        XCTAssertEqual(sut.productId, "1")
        XCTAssertEqual(sut.productName, "productName")
        XCTAssertEqual(sut.brandName, "brandName")
        XCTAssertEqual(sut.modelImage, "modelImage")
        XCTAssertEqual(sut.formattedPrice, "99.99 kr")
        XCTAssertEqual(sut.swatches, swatches)
    }
    
    func testDecodable() throws {
        let data = Data(Self.productJson.utf8)
        let sut = try JSONDecoder().decode(Product.self, from: data)
        
        XCTAssertEqual(sut.productId, "1245480001")
        XCTAssertEqual(sut.productName, "Relaxed Jeans")
        XCTAssertEqual(sut.brandName, "H&M")
        XCTAssertEqual(sut.modelImage, "https://image.hm.com/assets/hm/e5/29/e529a515f56d9f12632954548173f86c9c6e5c68.jpg")
        XCTAssertEqual(sut.formattedPrice, "349,00 kr.")
        XCTAssertEqual(sut.swatches.count, 2)
    }
    
    private static let productJson: String =
    """
    {
            "id": "1245480001",
            "trackingId": "OzQ7IzsxMjQ1NDgwMDAxOyM7IzsvZmFzaGlvbi9NT0JJTEUvU0VBUkNIX1BBR0UvU0VBUkNIX1JFU1VMVDsjOyM7T0JKRUNUSVZFJDsxNDU7NDc7IzsjOw_e4",
            "productName": "Relaxed Jeans",
            "external": false,
            "brandName": "H&M",
            "url": "/sv_se/productpage.1245480001.html",
            "showPriceMarker": false,
            "prices": [
              {
                "priceType": "whitePrice",
                "price": 349,
                "minPrice": 349,
                "maxPrice": 349,
                "formattedPrice": "349,00 kr."
              }
            ],
            "availability": {
              "stockState": "Available",
              "comingSoon": false
            },
            "swatches": [
              {
                "articleId": "1245480001",
                "url": "/sv_se/productpage.1245480001.html",
                "colorName": "Ljus denimblå",
                "colorCode": "8898AC",
                "trackingId": "OzQ7IzsxMjQ1NDgwMDAxOyM7IzsvZmFzaGlvbi9NT0JJTEUvU0VBUkNIX1BBR0UvU0VBUkNIX1JFU1VMVDsjOyM7T0JKRUNUSVZFJDsxNDU7NDc7IzsjOw_e4",
                "productImage": "https://image.hm.com/assets/hm/53/35/533592851b5f517dcbbc392d8d0fe9fe238b9ba4.jpg"
              },
              {
                "articleId": "1245480002",
                "url": "/sv_se/productpage.1245480002.html",
                "colorName": "Svart",
                "colorCode": "272628",
                "trackingId": "OzQ7IzsxMjQ1NDgwMDAyOyM7IzsvZmFzaGlvbi9NT0JJTEUvU0VBUkNIX1BBR0UvU0VBUkNIX1JFU1VMVDsjOyM7T0JKRUNUSVZFJDsxNDU7NDc7IzsjOw_e4",
                "productImage": "https://image.hm.com/assets/hm/b8/09/b809cc6ac1df64c372f7297acd63436c1d6b067b.jpg"
              }
            ],
            "productMarkers": [],
            "images": [
              {
                "url": "https://image.hm.com/assets/hm/81/af/81af2f3c796525515183e35fc03599d816c57943.jpg"
              },
              {
                "url": "https://image.hm.com/assets/hm/08/03/0803c266526383ae622764db5db5c69b179d6b61.jpg"
              },
              {
                "url": "https://image.hm.com/assets/hm/f0/f8/f0f8a02b438c2630e7340402c754e90a5df984cc.jpg"
              },
              {
                "url": "https://image.hm.com/assets/hm/79/ee/79ee5b5bc8d315ad6a851e3a19f94828744348ab.jpg"
              }
            ],
            "hasVideo": false,
            "colorName": "Ljus denimblå",
            "isPreShopping": false,
            "isOnline": true,
            "modelImage": "https://image.hm.com/assets/hm/e5/29/e529a515f56d9f12632954548173f86c9c6e5c68.jpg",
            "colors": "8898AC",
            "colourShades": "Babyblå|Ljusblå|Pastellblå",
            "productImage": "https://image.hm.com/assets/hm/53/35/533592851b5f517dcbbc392d8d0fe9fe238b9ba4.jpg",
            "newArrival": false,
            "isLiquidPixelUrl": false,
            "colorWithNames": "blå_0000ff",
            "mainCatCode": "men_jeans_relaxed"
    }
    """
}

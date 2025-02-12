//
//  UIColor+Extensions.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-11.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: String) {
        let start = hex.index(hex.startIndex, offsetBy: 0)
        let hexColor = String(hex[start...])

        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            let r, g, b: CGFloat
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255

                self.init(red: r, green: g, blue: b, alpha: 1.0)
                return
            }
        }

        self.init()
    }
}

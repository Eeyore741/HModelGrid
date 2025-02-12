//
//  DemoImageProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-11.
//

import UIKit

/// Demo type conforming to `ImageProvider`, serving UI building/preview purposes.
actor DemoImageProvider {
    
    private static let bundledImageName: String = "demoJeans"
    
    var mode: DemoImageProvider.Mode
    var delayInSeconds: UInt64
    
    init(mode: DemoImageProvider.Mode = .success, delayInSeconds: UInt64 = 1) {
        self.mode = mode
        self.delayInSeconds = delayInSeconds
    }
}

/// `ImageProvider` conforming extension.
extension DemoImageProvider: ImageProvider {
    
    func getImageWithURL(_ imageURL: URL) async throws -> UIImage {
        switch self.mode {
        case .success:
            guard let image = UIImage(named: Self.bundledImageName) else { throw ImageProviderError.dataDecoding }
            
            try await Task.sleep(nanoseconds: self.delayInSeconds * 1_000_000_000)
            
            return image
        case .error(let error):
            
            try await Task.sleep(nanoseconds: self.delayInSeconds * 1_000_000_000)
            
            throw error
        }
    }
}

extension DemoImageProvider {
    
    /// Type defines `DemoImageProvider` behaviour.
    enum Mode {
        
        /// `DemoImageProvider` instance returns bundeled `UIImage` on request.
        case success
        
        /// `DemoImageProvider` throws error on `UIImage` request.
        case error(ImageProviderError)
    }
}

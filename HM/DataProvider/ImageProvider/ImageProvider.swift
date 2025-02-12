//
//  ImageProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-10.
//

import UIKit

/// Protocol defines requirements for type serving as `UIImage` provider gained from `URL`.
protocol ImageProvider: Sendable {
    
    /// Function provides image with given `URL` parameter.
    /// - Parameter imageURL: `URL` instance to fetch `UIImage` from.
    /// - Returns: `UIImage` instance gained from given `URL`.
    func getImageWithURL(_ imageURL: URL) async throws -> UIImage
}

/// Type describes possible error cases of `ImageProvider`.
enum ImageProviderError: Error {
    
    /// Error trying to reach remote resource.
    case resourceUnreachable
    
    /// Error decoding `Data` into `UIImage` instance.
    case dataDecoding
    
    /// Error on scaling `UIImage` step.
    case scale
}

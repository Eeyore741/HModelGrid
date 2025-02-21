//
//  RemoteImageProvider.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-10.
//

import UIKit

/// Type conforming to `ImageProvider`, utilizing remote data provider.
actor RemoteImageProvider {
    
    private let resourceProvider: RemoteDataProvider
    private let imageScale: CGFloat
    private let cache: NSCache<NSString, UIImage>
    
    /// Initialize instance of `ImageProvider`.
    /// - Parameter imageScale: Value between 0 and 1 defines scale factor for result `UIImage`.
    /// - Parameter imageCacheCount: Number of images to be persisted in cache.
    init(imageScale: CGFloat = 1, imageCacheCount: Int = 20) {
        self.resourceProvider = RemoteDataProvider()
        self.imageScale = imageScale
        self.cache = NSCache<NSString, UIImage>()
        cache.countLimit = imageCacheCount
    }
}

/// `ImageProvider` conforming extension.
extension RemoteImageProvider: ImageProvider {
    
    func getImageWithURL(_ imageURL: URL) async throws -> UIImage {
        if let cachedImage = await self.getCacheImageWithUrl(imageURL) {
            return cachedImage
        }
        let data = try await self.resourceProvider.getRemoteResourceWithUrl(imageURL)
        
        guard let image = UIImage(data: data) else { throw ImageProviderError.dataDecoding }
        
        let downscaledImage = try await self.downscaleImage(image, scale: self.imageScale)
        
        await self.setCacheImage(downscaledImage, withUrl: imageURL)
        
        return downscaledImage
    }
}

/// Private helper methods.
private extension RemoteImageProvider {
    
    func setCacheImage(_ image: UIImage, withUrl url: URL) async {
        let nsStringUrl = url.absoluteString as NSString
        self.cache.setObject(image, forKey: nsStringUrl)
    }
    
    func getCacheImageWithUrl(_ url: URL) async -> UIImage? {
        let nsStringUrl = url.absoluteString as NSString
        return self.cache.object(forKey: nsStringUrl)
    }
    
    func downscaleImage(_ image: UIImage, scale: CGFloat) async throws -> UIImage {
        let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let newImage else { throw ImageProviderError.scale }
        
        return newImage
    }
}

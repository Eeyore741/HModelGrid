//
//  ProductView.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-10.
//

import SwiftUI

struct ProductView: View {
    
    @StateObject
    var viewModel: ProductViewModel
    
    var body: some View {
        VStack {
            switch self.viewModel.state {
            case .initial:
                ProgressView()
                    .task {
                        await self.viewModel.fetchImage()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            case .fetching:
                ProgressView()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            case .idle:
                Image(uiImage: self.viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .clipped()
                VStack {
                    Text(self.viewModel.brandName)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(self.viewModel.productName)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(self.viewModel.formattedPrice)
                        .font(.callout)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading)
                PaletteView(limit: self.viewModel.paletteLimit, colors: self.viewModel.paletteColors)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .bottom])
            }
        }
    }
}

#Preview {
    let swatches = [
        Swatch(id: "articleId", colorName: "Red", colorCode: "ff0000"),
        Swatch(id: "articleId", colorName: "Green", colorCode: "00ff00"),
        Swatch(id: "articleId", colorName: "Blue", colorCode: "0000ff"),
        Swatch(id: "articleId", colorName: "Black", colorCode: "000000")
    ]
    let product = Product(
        productId: "ProductId",
        productName: "ProductName",
        brandName: "BrandName",
        modelImage: "ModelImage",
        formattedPrice: "FormattedPrice",
        swatches: swatches
    )
    let imageProvider = DemoImageProvider(
        mode: .success,
        delayInSeconds: 2
    )
    let viewModel = ProductViewModel(
        product: product,
        imageProvider: imageProvider,
        paletteLimit: 3,
        errorImage: UIImage(imageLiteralResourceName: "error")
    )
    ProductView(viewModel: viewModel)
}

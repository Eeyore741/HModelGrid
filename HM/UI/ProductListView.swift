//
//  ProductListView.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-09.
//

import SwiftUI

/// View displaying vertical grid of `Product` instances.
struct ProductListView: View {
    
    @StateObject
    var viewModel: ProductListViewModel
    
    private let columns = [
       GridItem(.flexible(), spacing: 0),
       GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        switch self.viewModel.state {
        case .idle, .fetching:
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(Array(viewModel.products.enumerated()), id: \.offset) { index, element in
                        self.makeViewWithItem(element)
                            .frame(maxWidth: .infinity, minHeight: 400)
                            .task {
                                if index == self.viewModel.products.count - 1 {
                                    Task {
                                        await viewModel.fetchNextPage()
                                    }
                                }
                            }
                    }
                }
            }
        case .error:
            Text("ERROR")
                .padding(4)
            Button {
                Task {
                    await self.viewModel.refresh()
                }
            } label: {
                Text("Refresh")
            }
        case .initial, .refreshing:
            ProgressView()
                .task {
                    await self.viewModel.refresh()
                }
        }
    }
}

// MARK: Private accessories.
private extension ProductListView {
    
    @ViewBuilder
    func makeViewWithItem(_ item: Product) -> some View {
        let viewModel = self.viewModel.makeViewModelForProduct(item)
        ProductView(viewModel: viewModel)
    }
}

#Preview {
    let searchProvider = DemoSearchListProvider(
        mode: .success,
        getDelayInSeconds: 2
    )
    let imageProvider = DemoImageProvider(
        mode: .success,
        delayInSeconds: 2
    )
    let viewModel = ProductListViewModel(
        searchKeyword: String(),
        touchPoint: String(),
        errorImage: UIImage(),
        paletteLimit: 4,
        searchListProvider: searchProvider,
        imageProvider: imageProvider
    )
    ProductListView(viewModel: viewModel)
}

//
//  ProductView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import SwiftUI
internal import Combine

@MainActor
final class ProductViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published var selectedFilter: FilterOption? = nil
    @Published var selectedCategory: CategoryOption? = nil
    
    func getAllProducts()async throws{
        self.products = try await ProductManager.share.getAllProducts()
    }
    
    //MARK: - Filter Option
    enum FilterOption: String, CaseIterable {
        case noFilter
        case priceHigh
        case priceLow
    }

    func filterSelected(option: FilterOption) async throws{
        switch option {
        case .noFilter:
            self.products = try await ProductManager.share.getAllProducts()
            break
        case .priceHigh:
            self.products = try await ProductManager.share.getAllProductSortedByPrice(desceding: true)
            break
        case .priceLow:
            self.products = try await ProductManager.share.getAllProductSortedByPrice(desceding: false)
            break
        }
        self.selectedFilter = option
    }
    
    //MARK: - Filter BY Category
    enum CategoryOption: String, CaseIterable {
        case noCategory
        case beauty
        case fragrances
        case furniture
        case groceries
    }
    func CategorySelected(option: CategoryOption) async throws{
        switch option {
        case .noCategory:
            self.products = try await ProductManager.share.getAllProducts()
            break
        case .beauty,.fragrances,.furniture,.groceries:
            self.products = try await ProductManager.share.getAllProductForCategory(category: option.rawValue)
            break
        }
        self.selectedCategory = option
    }

}

struct ProductView: View {
    
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        List{
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Product")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "None")") {
                    ForEach(ProductViewModel.FilterOption.allCases, id: \.self) { filterOption in
                        Button(filterOption.rawValue) {
                            Task{
                               try await viewModel.filterSelected(option: filterOption)
                            }
                        }
                    }
                }// Menu
            }// ToolbarItem
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Category: \(viewModel.selectedCategory?.rawValue ?? "None")") {
                    ForEach(ProductViewModel.CategoryOption.allCases, id: \.self) { categoryOption in
                        Button(categoryOption.rawValue) {
                            Task{
                                try await viewModel.CategorySelected(option: categoryOption)
                            }
                        }
                    }
                }// Menu
            }// ToolbarItem
        }
        .task {
            try? await viewModel.getAllProducts()
        }
        
    }
}

#Preview {
    ProductView()
}


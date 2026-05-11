//
//  ProductView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import SwiftUI
import FirebaseFirestore

internal import Combine

@MainActor
final class ProductViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    @Published var selectedFilter: FilterOption? = nil
    @Published var selectedCategory: CategoryOption? = nil
    private var LastDocument: DocumentSnapshot? = nil
    
//    func getAllProducts()async throws{
//        self.products = try await ProductManager.share.getAllProducts()
//    }
    
    //MARK: - Filter Option
    enum FilterOption: String, CaseIterable {
        case noFilter
        case priceHigh
        case priceLow
        
        var priceDesceding: Bool?{
            switch self {
            case .noFilter: return nil
            case .priceHigh: return true
            case .priceLow: return false
            }
        }
    }

    func filterSelected(option: FilterOption){
        self.selectedFilter = option
        self.products = []
        self.LastDocument = nil
        self.getProducts()
        
//        switch option {
//        case .noFilter:
//            self.products = try await ProductManager.share.getAllProducts()
//            break
//        case .priceHigh:
//            self.products = try await ProductManager.share.getAllProductSortedByPrice(desceding: true)
//            break
//        case .priceLow:
//            self.products = try await ProductManager.share.getAllProductSortedByPrice(desceding: false)
//            break
//        }
       
    }
    
    //MARK: - Filter BY Category
    enum CategoryOption: String, CaseIterable {
        case noCategory
        case beauty
        case fragrances
        case furniture
        case groceries
        
        var categoryKey: String?{
            if self == .noCategory {
                return nil
            }
            return self.rawValue
        }
    }
    
    func categorySelected(option: CategoryOption){
        self.selectedCategory = option
        self.products = []
        self.LastDocument = nil
        self.getProducts()
        
//        switch option {
//        case .noCategory:
//            self.products = try await ProductManager.share.getAllProducts()
//            break
//        case .beauty,.fragrances,.furniture,.groceries:
//            self.products = try await ProductManager.share.getAllProductForCategory(category: option.rawValue)
//            break
//        }
//        
    }
    
    func getProducts() {
        Task{
            let (newProduct, lastDocument) = try await ProductManager
                .share
                .getAllProducts(priceDesceding: selectedFilter?.priceDesceding,
                                ForCategory: selectedCategory?.categoryKey,
                                count: 10, lastDocument: LastDocument)
            self.products.append(contentsOf: newProduct)
            self.LastDocument = lastDocument
        }
    }
    
    
    func getAllProductByCount(){
        Task{
          let count = try await ProductManager.share.getAllProductsCount()
            print("Total coutn \(count)")
        }
    }
    
//    func getProductByRating() {
//        Task{
////            let newProduct = try await ProductManager
////                .share
////                .getAllProductsByRating(count: 3, lastRate: self.products.last?.rating)
//            
//            let (newProduct, lastDocument) = try await ProductManager
//                .share
//                .getAllProductsByRating(count: 3, lastDocument: LastDocument)
//            
//            self.products.append(contentsOf: newProduct)
//            self.LastDocument = lastDocument
//            
//        }
//    }

}

struct ProductView: View {
    
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        List{
            
            ForEach(viewModel.products, id: \.id) { product in
                ProductCellView(product: product)
                
                    .onAppear {
                        // Load more when reaching last item
                        if product.id == viewModel.products.last?.id {
                            viewModel.getProducts()
                        }
                    }
            }
            
        }
        .navigationTitle("Product")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "None")") {
                    ForEach(ProductViewModel.FilterOption.allCases, id: \.self) { filterOption in
                        Button(filterOption.rawValue) {
                            Task{
                               viewModel.filterSelected(option: filterOption)
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
                                viewModel.categorySelected(option: categoryOption)
                            }
                        }
                    }
                }// Menu
            }// ToolbarItem
        }
        .onAppear{
            viewModel.getProducts()
            viewModel.getAllProductByCount()
        }
        
    }
}

#Preview {
    ProductView()
}


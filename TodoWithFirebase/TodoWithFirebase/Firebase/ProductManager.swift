//
//  ProductManager.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import Foundation
import FirebaseFirestore
import Firebase


final class ProductManager {
    static let share = ProductManager()
    private init(){}
    
    private let productCollection = Firestore.firestore().collection("products")
    
    private func productDocument(productId: String) -> DocumentReference {
        productCollection.document(productId)
    }
    
//    func uploadProduct(product: Product) async throws{
//        try productDocument(productId: String(product.id)).setData(from: product, merge: false)
//    }
    
   private func getAllProducts() async throws -> [Product] {
        try await productCollection.getDocuments2(as: Product.self)
    }
    
    func getProduct(productId: String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
    }
    
   private func getAllProductSortedByPrice(desceding: Bool) async throws -> [Product] {
        try await productCollection
            .order(by: Product.CodingKeys.price.rawValue, descending: desceding)
            .getDocuments2(as: Product.self)
    }
    
   private func getAllProductForCategory(category: String) async throws -> [Product] {
        try await productCollection
            .whereField( Product.CodingKeys.category.rawValue, isEqualTo: category)
            .getDocuments2(as: Product.self)
    }
    
   private func getAllProductByPriceAndCategory(desceding: Bool, category: String) async throws -> [Product] {
       let categoryKey = Product.CodingKeys.category.rawValue
       let priceKey = Product.CodingKeys.price.rawValue
    
       return try await productCollection
           .whereField(categoryKey, isEqualTo: category)
           .order(by: priceKey, descending: desceding)
           .getDocuments2(as: Product.self)
    }
    
    func getAllProducts(priceDesceding desceding: Bool?, ForCategory category: String?) async throws -> [Product]{
        if let desceding, let category {
            return try await getAllProductByPriceAndCategory(desceding: desceding, category: category)
        }else if let desceding{
            return try await getAllProductSortedByPrice(desceding: desceding)
        }else if let category{
            return try await getAllProductForCategory(category: category)
        }
        return try await getAllProducts()
    }
}

extension Query{
    func getDocuments2(as type: Product.Type) async throws -> [Product]{
        let snapshot = try await self.getDocuments()
        
        var products: [Product] = []
        
        for document in snapshot.documents {
            let product = try document.data(as: Product.self)
            products.append(product)
        }
        
        return products
    }
}

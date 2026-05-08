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
    
    func uploadProduct(product: Product) async throws{
        try productDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    
    func getAllProducts() async throws -> [Product] {
        try await productCollection.getDocuments2(as: Product.self)
    }
    
    func getProduct(productId: String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
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

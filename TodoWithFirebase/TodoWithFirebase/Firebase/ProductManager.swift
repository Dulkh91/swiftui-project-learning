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
    
    func getProducts(productId: String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
    }
    
}

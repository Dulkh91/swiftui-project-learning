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
    
   private func getAllProducts() async throws -> [Product] {
       try await productCollection
           .getDocuments2(as: Product.self)
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
    
    func getAllProductsByRating(count: Int, lastRate: Double?) async throws -> [Product]{
        try await productCollection
            .order(by: Product.CodingKeys.rating.rawValue, descending: true)
            .limit(to: count)
            .start(after: [lastRate ?? 99999999])
            .getDocuments2(as: Product.self)
    }
    
    func getAllProductsByRating(count: Int, lastDocument: DocumentSnapshot?) async throws ->(products: [Product], lastDocument :DocumentSnapshot?){
        if let lastDocument {
           return try await productCollection
                .order(by: Product.CodingKeys.rating.rawValue, descending: true)
                .limit(to: count)
                .start(afterDocument: lastDocument)
                .getDocumentWithSnapshot(as: Product.self)
        }else{
          return  try await productCollection
                .order(by: Product.CodingKeys.rating.rawValue, descending: true)
                .limit(to: count)
                .getDocumentWithSnapshot(as: Product.self)
        }
    }
    
}//- ProductManager

extension Query{
//    func getDocuments2(as type: Product.Type) async throws -> [Product]{
//        let snapshot = try await self.getDocuments()
//        
//        var products: [Product] = []
//        
//        for document in snapshot.documents {
//            let product = try document.data(as: Product.self)
//            products.append(product)
//        }
//        
//        return products
//    }
  //Both the same
    /*
    func getDocuments2<T>(as type: T.Type) async throws -> [T] where T: Decodable{
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map { document in
            try document.data(as: T.self)
        }
    }
    */
    
    
    func getDocuments2<T>(as type: T.Type) async throws -> [T] where T: Decodable{
         try await getDocumentWithSnapshot(as: type).products
        //(products, lastDocument)
//        return products
    }
    
    
    func getDocumentWithSnapshot<T>(as Type: T.Type) async throws -> (products: [T], lastDocument :DocumentSnapshot?) where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        let products = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (products, snapshot.documents.last)
    }
}

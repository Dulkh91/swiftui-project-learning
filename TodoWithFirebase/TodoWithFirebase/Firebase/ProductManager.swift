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
    static let shared = ProductManager()
    private init(){}
    
    private let productCollection = Firestore.firestore().collection("products")
    
    private func productDocument(productId: String) -> DocumentReference {
        productCollection.document(productId)
    }
    

    
//   private func getAllProducts() async throws -> [Product] {
//       try await productCollection
//           .getDocuments2(as: Product.self)
//    }
//    
//   private func getAllProductSortedByPrice(desceding: Bool) async throws -> [Product] {
//        try await productCollection
//            .order(by: Product.CodingKeys.price.rawValue, descending: desceding)
//            .getDocuments2(as: Product.self)
//    }
//    
//   private func getAllProductForCategory(category: String) async throws -> [Product] {
//        try await productCollection
//            .whereField( Product.CodingKeys.category.rawValue, isEqualTo: category)
//            .getDocuments2(as: Product.self)
//    }
//    
//   private func getAllProductByPriceAndCategory(desceding: Bool, category: String) async throws -> [Product] {
//       let categoryKey = Product.CodingKeys.category.rawValue
//       let priceKey = Product.CodingKeys.price.rawValue
//    
//       return try await productCollection
//           .whereField(categoryKey, isEqualTo: category)
//           .order(by: priceKey, descending: desceding)
//           .getDocuments2(as: Product.self)
//    }
    
    
    private func getAllProductsQuery() -> Query{
        productCollection
     }
     
    private func getAllProductSortedByPriceQuery(desceding: Bool)  -> Query {
         productCollection
             .order(by: Product.CodingKeys.price.rawValue, descending: desceding)
     }
     
    private func getAllProductForCategoryQuery(category: String) -> Query {
          productCollection
             .whereField( Product.CodingKeys.category.rawValue, isEqualTo: category)
     }
     
    private func getAllProductByPriceAndCategoryQuery(desceding: Bool, category: String) -> Query {
        let categoryKey = Product.CodingKeys.category.rawValue
        let priceKey = Product.CodingKeys.price.rawValue
     
        return productCollection
            .whereField(categoryKey, isEqualTo: category)
            .order(by: priceKey, descending: desceding)
     }
    
    
    func getProduct(productId: String) async throws -> Product {
       try await productDocument(productId: productId).getDocument2(as: Product.self)
          
    }
    
    
    func getAllProducts(priceDesceding desceding: Bool?,
                        ForCategory category: String?,
                        count: Int,
                        lastDocument: DocumentSnapshot?)
    async throws -> (products: [Product], lastDocument :DocumentSnapshot?){
        
        var query: Query = getAllProductsQuery()
        
        if let desceding, let category {
            query = getAllProductByPriceAndCategoryQuery(desceding: desceding, category: category)
        }else if let desceding{
            query = getAllProductSortedByPriceQuery(desceding: desceding)
        }else if let category{
            query = getAllProductForCategoryQuery(category: category)
        }
        
        return try await query
            .startOptional(afterDocument: lastDocument)
            .getDocumentWithSnapshot(as: Product.self)
        
//        if let lastDocument {
//            return try await
//                query
//                .limit(to: count)
//                .start(afterDocument: lastDocument)
//                .getDocumentWithSnapshot(as: Product.self)
//        }else{
//            return try await
//                query
//                .limit(to: count)
//                .getDocumentWithSnapshot(as: Product.self)
//        }
        
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
    
    func getAllProductsCount() async throws -> Int{
        try await self.productCollection
            .getAggregation()
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
    
    func startOptional(afterDocument lastDocument: DocumentSnapshot? ) -> Query{
        guard let  lastDocument else {return self}
        return self.start(afterDocument: lastDocument)
        
    }
    
    func getAggregation()async throws ->Int{
        let snapshot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapshot.count)
    }
}

extension DocumentReference {
    func getDocument2<T>(as type: T.Type) async throws -> T where T: Decodable {
        let snapshot = try await self.getDocument()
        return try snapshot.data(as: T.self)
    }
}


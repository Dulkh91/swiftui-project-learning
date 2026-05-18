//
//  UserManager.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 6/5/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import FirebaseSharedSwift


struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoURL: String?
    let dateCreated: Date?
    
    init(userId: AuthDataResultModel) {
        self.userId = userId.uid
        self.email = userId.email
        self.photoURL = userId.photoURL
        self.dateCreated = Date()
    }
}

final class UserManager{
    static let shared = UserManager()
    private init(){}
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
    }
    
    private func userFavoriteProductCollection(userId: String) -> CollectionReference{
      userDocument(userId: userId).collection("favorite_product")
        
    }
    
    private func userFavoriteProductDocument(userId: String, favoriteId: String) -> DocumentReference{
        userFavoriteProductCollection(userId: userId).document(favoriteId)
    }
    
    private var encoder: Firestore.Encoder = {
        var encoded = Firestore.Encoder()
        encoded.keyEncodingStrategy = .convertToSnakeCase
        return encoded
    }()
    
    private var decoder: Firestore.Decoder = {
        var decoded = Firestore.Decoder()
        decoded.keyDecodingStrategy = .convertFromSnakeCase
        return decoded
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, encoder: encoder)
        
    }
    
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self,decoder: decoder )
    }
    
    
    
    /* //- Old method
    func addUserFavoriteProduct(userId: String, productId: String) async throws{
        let document = userDocument(userId: userId).collection("favorite_product").document()
        let documentId = document.documentID
        
        let data:[String:Any] = [
            "id": documentId,
            "productId": productId,
            "createdAt": Timestamp()
        ]
        
        try await document.setData(data, merge: false)
        
    }
    
    func removeUserFavoriteProduct(userId: String, favoriteId: String) async throws{
        try await userDocument(userId: userId)
            .collection("favorite_product")
            .document(favoriteId)
            .delete()
    }
     */
    
    // New method with emplement 
    func addUserFavoriteProduct(userId: String, productId: Int) async throws{
        let document = userFavoriteProductCollection(userId: userId).document()
        let documentId = document.documentID
        
        let data:[String:Any] = [
            UserFavoriteProduct.CodingKeys.id.rawValue : documentId,
            UserFavoriteProduct.CodingKeys.productId.rawValue : productId,
            UserFavoriteProduct.CodingKeys.createdAt.rawValue : Timestamp()
        ]
        
        try await document.setData(data, merge: false)
    }
    
    func removeUserFavoriteProduct(userId: String, favoriteId: String) async throws{
        try await userFavoriteProductDocument(userId: userId, favoriteId: favoriteId)
            .delete()
    }
    
    
    func getUserAllFavoriteProduct(userId: String) async throws -> [UserFavoriteProduct] {
        
        let result = userFavoriteProductCollection(userId: userId)
        let data = try await result.getDocuments2(as: UserFavoriteProduct.self)
        return  data
        
    }
    
}




struct UserFavoriteProduct: Codable{
    let id: String
    let productId: Int
    let createdAt: Date
    
    
    // នេះហៅមកពីលើនៃ encode និង decode
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "productId"
        case createdAt = "createdAt"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.productId = try container.decode(Int.self, forKey: .productId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.productId, forKey: .productId)
        try container.encode(self.createdAt, forKey: .createdAt)
    }
    
    
}


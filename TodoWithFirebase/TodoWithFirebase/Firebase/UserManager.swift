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
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
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
    
}


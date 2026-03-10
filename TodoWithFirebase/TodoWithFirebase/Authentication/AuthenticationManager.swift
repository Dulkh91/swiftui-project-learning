//
//  AuthenticationManager.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 6/3/26.
//

import SwiftUI
import FirebaseAuth

struct AuthDataResultModel {
    var uid: String
    var email: String?
    var photoURL: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
    
}

enum AuthProviderOptions: String{
    case email = "password"
    case google = "google.com"
}

class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init(){}
    
    func getAuthenticateUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.cannotFindHost)
        }
        return AuthDataResultModel(user: user)
    }
    
    
    func getProviders() throws -> [AuthProviderOptions]{
        guard let providerData = Auth.auth().currentUser?.providerData else{
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOptions] = []
        for provider in providerData{
            if let option  = AuthProviderOptions(rawValue: provider.providerID){
                providers.append(option)
            }else{
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    
    func sigOut()throws{
        try Auth.auth().signOut()
    }
}

//MARK: - SIGN IN WITH EMAIL AND PASSWORD
extension AuthenticationManager{
    @discardableResult
    func creatUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDtaResult =  try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDtaResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDtaResult =  try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDtaResult.user)
    }
    
    func resetPassword(password: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: password)
    }
    
    func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
}


//MARK: - SIGN IN WITH GMAIL
extension AuthenticationManager{
    @discardableResult
    func signinWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credentail = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signin(credentail: credentail)
    }
    
    func signin(credentail: AuthCredential) async throws -> AuthDataResultModel{
        let authResult = try await Auth.auth().signIn(with: credentail)
        
        return AuthDataResultModel(user: authResult.user)
    }
    
    
}

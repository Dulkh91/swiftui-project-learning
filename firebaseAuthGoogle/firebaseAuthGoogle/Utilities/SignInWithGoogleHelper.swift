//
//  SignInWithGoogleHelper.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import Foundation
import GoogleSignIn

struct GoogleSignInResultModel{
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
    
}


class SignInWithGoogleHelper{
    
    func signInWithGoogle() async throws-> GoogleSignInResultModel{
        // ១. ស្វែងរក Top View Controller សម្រាប់បង្ហាញផ្ទាំង Sign In
        guard let topVC = Utilities.shared.topViewController() else{
            throw URLError(.badServerResponse)
        }
        
        // ២. ហៅផ្ទាំង Google Sign In
        let giSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        // ៣. ចាប់យក Tokens
        guard let idToken = giSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        
        
        let accessToken = giSignInResult.user.accessToken.tokenString
        let name = giSignInResult.user.profile?.name
        let email = giSignInResult.user.profile?.email
        
        let tokents = GoogleSignInResultModel(idToken: idToken,
                                             accessToken: accessToken,
                                             name: name,
                                             email: email)
        
        return tokents
        
    }
}

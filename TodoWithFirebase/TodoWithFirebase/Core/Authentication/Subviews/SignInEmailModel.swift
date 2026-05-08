//
//  SignInEmailModel.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 4/5/26.
//

import Foundation
internal import Combine

@MainActor
final class SignInEmailModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        let authDataResult = try await AuthenticationManager.shared.creatUser(email: email, password: password)
        let user = DBUser.init(userId: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
        
    }//: SignUp
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        let _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }//: SignIn
}

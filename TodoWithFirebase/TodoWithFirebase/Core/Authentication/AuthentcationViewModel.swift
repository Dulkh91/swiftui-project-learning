//
//  AuthentcationViewModel.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 4/5/26.
//

import Foundation
internal import Combine

@MainActor
final class AuthentcationViewModel: ObservableObject{
    
    func signIn() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signinWithGoogle(tokens: tokens)
        let user = DBUser(userId: authDataResult)

        try await UserManager.shared.createNewUser(user: user)
           
    }
}

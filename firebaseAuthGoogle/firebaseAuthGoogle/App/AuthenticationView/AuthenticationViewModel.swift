//
//  AuthenticationViewModel.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import Foundation
import Combine

final class AuthenticationViewModel: ObservableObject{
    
    func signInWithGoogle() async throws{
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signInWithGoogle()
        try await AuthenticationManager.shared.signInWithGoogle(token: tokens)
    }
    
}

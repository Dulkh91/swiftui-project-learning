//
//  SettingViewModel.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 4/5/26.
//

import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOptions] = []
    
    func loadAuthProviders(){
        if let providers = try? AuthenticationManager.shared.getProviders(){
            authProviders = providers
        }
    }
    
    func signOut(){
       try? AuthenticationManager.shared.sigOut()
    }
    
    func resetPassword() async throws{
        let authUser =  try AuthenticationManager.shared.getAuthenticateUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try? await AuthenticationManager.shared.resetPassword(password: email)
    }
    
    func updateEmail()async throws{
        let email = "dul123@example.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
        
    }
    
    func updatePassword() async throws{
        let password = "1234567"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}

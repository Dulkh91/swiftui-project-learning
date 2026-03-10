//
//  SettingView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 7/3/26.
//

import SwiftUI
internal import Combine

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


struct SettingView: View {
    //MARK: - PROPERTY
    @ObservedObject private var vm = SettingsViewModel()
    @Binding var showSignInView:Bool
    
    //MARK: - BODY
    var body: some View {
        List {
            Button {
                Task{
                    do{
                      vm.signOut()
                        showSignInView = true
                    }
                }
            } label: {
                Text("Sign Out")
            }//: BUTTON
           
            //MARK: - Email Funciton
            if vm.authProviders.contains(.email){
                emailSection
            }
            
        }//: LIST
        .onAppear{
            vm.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

extension SettingView{
    private var emailSection: some View{
        Section {
            Button {
                Task{
                    do{
                       try await vm.resetPassword()
                        print("Password reset!")
                    }
                }
            } label: {
                Text("Reset password")
            }//: BUTTON
            
            Button {
                Task{
                    do{
                        try await vm.updateEmail()
                        print("update email!")
                    }
                }
            } label: {
                Text("Update Email")
            }//: BUTTON
            
            Button {
                Task{
                    do{
                        try await vm.updatePassword()
                        print("Update Password!")
                    }
                }
            } label: {
                Text("Update Password")
            }//: BUTTON
        } header: {
            Text("Email Functions")
        }
    }
}


#Preview {
    NavigationStack {
        SettingView(showSignInView: .constant(true))
    }
}




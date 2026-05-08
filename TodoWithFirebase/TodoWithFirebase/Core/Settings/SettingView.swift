//
//  SettingView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 7/3/26.
//

import SwiftUI

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




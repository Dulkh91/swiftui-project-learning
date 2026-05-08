//
//  AuthenticationView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 6/3/26.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth




struct AuthenticationView: View {
    //MARK: - PROPERTY
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = AuthentcationViewModel()
    //MARK: - BODY
    var body: some View {
        VStack {
            NavigationLink{
                SignInEmailView( showSignInView: $showSignInView)
            }label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue.cornerRadius(10))
            }
            
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal), action: {
                Task {
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                    } catch {
                        print("Google sign-in failed: \(error)")
                    }
                }
            })
            
            
            
            .navigationTitle("Sign In")
            
            Spacer()
        }//: VSTACK
        .padding()
    }
}

//MARK: - PREVIEW
#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
    
}


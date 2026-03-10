//
//  SignInEmailView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 6/3/26.
//

import SwiftUI
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
        let _ = try await AuthenticationManager.shared.creatUser(email: email, password: password)
        
    }//: SignUp
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        let _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }//: SignIn
}

struct SignInEmailView: View {
    //MARK: - PROPERTY
    @StateObject var vm = SignInEmailModel()
    @Binding var showSignInView: Bool
    
    //MARK: - BODY
    var body: some View {
        VStack {
            TextField("Email...", text: $vm.email)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $vm.password)
                .padding()
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task{
                    do {
                        try await vm.signUp()
                        showSignInView = false // dismiss SignInEmailView 
                    }catch{
                        print("Error signing in: \(error)")
                    }
                    
                    do {
                       try await vm.signIn()
                        showSignInView = false // dismiss SignInEmailView
                    }catch{
                        print("Error signing in: \(error)")
                    }
                    
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue.cornerRadius(10))
            }

            Spacer()
        }//: VSTACK
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack{
        SignInEmailView( showSignInView: .constant(false))
    }
    
}

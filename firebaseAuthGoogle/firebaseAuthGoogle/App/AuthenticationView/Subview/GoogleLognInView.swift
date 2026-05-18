//
//  GoogleLognInView.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleLognInView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Binding var showLognInScreen: Bool
    var body: some View {
        GoogleSignInButton(scheme:.dark, style: .wide, state: .normal){
            Task{
                do{
                   try await viewModel.signInWithGoogle()
                    showLognInScreen = false
                }
            }
        }
    }
}

#Preview {
    GoogleLognInView(viewModel: AuthenticationViewModel(), showLognInScreen: .constant(false))
}

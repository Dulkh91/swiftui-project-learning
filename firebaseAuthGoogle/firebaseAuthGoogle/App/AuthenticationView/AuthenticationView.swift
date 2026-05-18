//
//  AuthenticationView.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject private var vm = AuthenticationViewModel()
    @Binding var showLognInScreen: Bool
    var body: some View {
        NavigationStack{
            List{
                GoogleLognInView(
                    viewModel: vm,
                    showLognInScreen: $showLognInScreen
                )
            }
            
            
            .navigationTitle("Logn In")
        }
    }
}

#Preview {
    AuthenticationView(showLognInScreen: .constant(false))
}

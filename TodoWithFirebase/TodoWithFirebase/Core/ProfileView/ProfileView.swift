//
//  ProfileView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 4/5/26.
//

import SwiftUI
internal import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws{
         let authDataResult = try AuthenticationManager.shared.getAuthenticateUser()
        self.user  = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}


struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            if let user = viewModel.user{
                Text("UserId: \(user.userId)")
            }
        }
        .task{
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink{
                    SettingView(showSignInView: $showSignInView)
                }label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView(showSignInView: .constant(true))
    }
}

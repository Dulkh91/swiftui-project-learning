//
//  SettingView.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var mv = SettingViewModel()
    @Binding var showLognInScreen: Bool
    var body: some View {
        NavigationStack{
            List{
                Button {
                    Task{
                        do{
                          try mv.sigOut()
                            showLognInScreen = true
                        }
                    }
                } label: {
                    Text("Log out")
                }

            }
            
            
            .navigationTitle("Setting")
        }
    }
}

#Preview {
    SettingView(showLognInScreen: .constant(false))
}

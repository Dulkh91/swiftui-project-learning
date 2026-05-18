//
//  RootView.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import SwiftUI

struct RootView: View {
    @State private var showLognInScreen: Bool = false
    var body: some View {
        ZStack{
            if !showLognInScreen{
                HomeView(showLognInScreen: $showLognInScreen)
            }
        }
        
        // #1 ពេលបើក app ដំបូងថាយើងបាន login ហើយឬនៅ?
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticationUser()
            
            //ប្រសិនជា authUser គឺ nil វា true បើបាន login គឺ false
            self.showLognInScreen = (authUser == nil)
        }
        
        // #2 ប្រសិនជាមិនទាន login វាដើរទីនេះ
        .fullScreenCover(isPresented: $showLognInScreen) {
            AuthenticationView(showLognInScreen: $showLognInScreen)
        }
        
        
    }
}

#Preview {
    RootView()
}

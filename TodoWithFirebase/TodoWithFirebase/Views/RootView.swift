//
//  RootView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 6/3/26.
//

import SwiftUI

struct RootView: View {
    //MARK: - PROPERTY
    @State private var showSignInView: Bool = false
    //MARK: - BODY
    var body: some View {
        ZStack{
            if !showSignInView{
                NavigationStack{
                    SettingView(showSignInView: $showSignInView)
                    }
                }
            }//: ZSTACK
            .onAppear{// បើក app ដំបូង
                let authUser = try? AuthenticationManager.shared.getAuthenticateUser()
                self.$showSignInView.wrappedValue = authUser == nil
            }
            
            .fullScreenCover(isPresented: $showSignInView){
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
            }//: FULLSCREENCOVER
    }
}

#Preview {
    RootView()
}

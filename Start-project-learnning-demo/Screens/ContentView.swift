//
//  ContentView.swift
//  Start-project-learnning-demo
//
//  Created by Ros Dul on 13/2/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    var body: some View {
        if isOnboardingActive {
            OnboardingView()
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}

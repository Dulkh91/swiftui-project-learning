//
//  Onboarding.swift
//  Start-project-learnning-demo
//
//  Created by Ros Dul on 13/2/26.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingCompleted: Bool = true
    var body: some View {
        VStack(spacing: 20){
            Text("Boarding".uppercased())
                .font(.largeTitle)
            Button {
                isOnboardingCompleted = false
            } label: {
                Text("Sart")
                    .font(.headline)
            }

        }
    }
}

#Preview {
    OnboardingView()
}

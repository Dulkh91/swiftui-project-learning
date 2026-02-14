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
        ZStack {
            Color.yellow.ignoresSafeArea()
            
            VStack{
                Spacer()
                //MARK: - HEADER
                VStack{
                    Group {
                        Text("iOS Developer")
                            .font(.system(size: 50))
                            .fontWeight(.heavy)
                        Text(
                            "Hello I'm beginner iOS developer. I want to learn SwiftUI and make a project."
                        )
                        .font(.title3)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                    }
                    .foregroundColor(.white)
                    
                }//End header
                
                //MARK: - IMAGE LOGO
                VStack{
                    ZStack {
                        Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 40)
                            .frame(width: 260, height: 260,alignment: .center)
                        
                        Circle()
                            .stroke(.white.opacity(0.3),
                                    lineWidth: 80
                            )
                            .frame(width: 260, height: 260, alignment: .center)
                        
                        
                        Image("imageDul")
                            .resizable()
                            .scaledToFit()
                    }
                }//ENG: image logo
                
                Spacer()
                //MARK: - FOOTER
                ZStack{
                    //1 background (static)
                    Capsule()
                        .fill(Color.white.opacity(0.4))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.4))
                        .padding(8)
                    
                    //2 Call action
                        Text("Get started")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.blue)
                        .offset(x: 20)
                    
                    // 3 capule dymanic
                    HStack{
                        Capsule()
                            .fill(Color(.systemRed))
                            .frame(width: 80)
                       Spacer()
                    }
                    //CIRCLE DRAG
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color(.systemRed))
                            
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 28, weight: .bold))
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .onTapGesture {
                        isOnboardingCompleted = false
                    }
                    
                }//ENT FOOTER
                .frame(height: 80, alignment: .center)
                .padding()
            
                
            }
            
        }
    }
}

#Preview {
    OnboardingView()
}

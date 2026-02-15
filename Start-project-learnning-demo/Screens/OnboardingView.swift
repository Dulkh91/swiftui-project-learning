//
//  Onboarding.swift
//  Start-project-learnning-demo
//
//  Created by Ros Dul on 13/2/26.
//

import SwiftUI
import Foundation
import AVFoundation

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingCompleted: Bool = true
    @State private var showImage = false
    @State private var isAnimate: Bool = false
    @State private var imageOffset: CGSize = .zero
    
//    @State private var buttonWith: Double =  UIScreen.main.bounds.width - 80
    @State private var buttonOfSet: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            
            GeometryReader{geo in
                let buttonWith = geo.size.width - 80
                
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
                            //Reuse  view of circle group view
                            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.4)
                                .offset(x: imageOffset.width * -1)
                                .blur(radius: Double(abs(imageOffset.width) / 5))
                                .animation(.easeOut(duration: 1), value: imageOffset)
                            
                            
                            if showImage {
                                Image("imageDul")
                                    .resizable()
                                    .scaledToFit()
                                    .transition(.scale)
                                    .offset(x: imageOffset.width * 1.2  , y: 0) // * 1.2 ដើម្បីបន្ថែមល្បឿន
                                    .rotationEffect(Angle(degrees: Double(imageOffset.width / 30)))
                                    .gesture(
                                        DragGesture()
                                            .onChanged{gesture in
                                                if abs(imageOffset.width) <= 150 {
                                                    imageOffset = gesture.translation
                                                }
                                                //abs(imageOffset.width) គឺប្តូរលេខទាំងអស់មកជា positive number
                                            }
                                            .onEnded{_ in
                                                imageOffset = .zero
                                            }
                                    )
                            }
                            
                        }
                        .onAppear{
                            withAnimation(.spring(response: 0.5,
                                                  dampingFraction: 0.6,
                                                  blendDuration: 0.26
                                                 )) {
                                showImage = true
                            }
                        }
                    }//ENG: image logo
                    
                    Spacer()
                    //MARK: - FOOTER
                    ZStack {
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
                                    .frame(width: buttonOfSet + 80)
                                
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
                                .frame(width: 80,height: 80, alignment: .center)
                                .offset(x: buttonOfSet)
                                .gesture(
                                    DragGesture()
                                        .onChanged { guesture in
                                            if guesture.translation.width > 0 &&
                                                buttonOfSet <= buttonWith - 80
                                            {
                                                buttonOfSet = guesture.translation.width
                                            }
                                        }
                                    
                                        .onEnded{ _ in
                                            playAudio(soundName: "bell1", type: "mp3")
                                            withAnimation(Animation.easeOut(duration: 0.4)) {
                                                if buttonOfSet <= buttonWith / 2 {
                                                    buttonOfSet = 0
                                                }else{
                                                    isOnboardingCompleted = false
                                                }
                                            }
                                        }
                                )
                                
                                Spacer()
                            }
                            
                        }//END FOOTER on zstack
                        .frame(width: buttonWith,height: 80, alignment: .center)
                        .padding()
                    }
            }//end Vstack
        }// end GOE
     }//end ZSTACK
        .onAppear {
            isAnimate = true
        }
    }// End BODY
}

#Preview {
    OnboardingView()
}

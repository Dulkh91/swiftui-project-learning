//
//  Home.swift
//  Start-project-learnning-demo
//
//  Created by Ros Dul on 13/2/26.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isHomeActive: Bool = false
    var body: some View {
        VStack(spacing: 20){
            //MARK: -HEARDER
            Spacer()
            
            ZStack{
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.4)
                
                Image("imageDul")
                    .resizable()
                    .scaledToFit()
            }
            
            //MARK: -CENTER
            Text(
                "I has been learned swift UIKIT and have a one project but now swiftui is populer than swift UIKIT so I will try to learn swiftUI. I will try to make a simple app to show you how to use it."
            )
            .padding()
            .multilineTextAlignment(TextAlignment.center)
            .font(.system(.title3))
            .foregroundColor(.gray)
            
            
            //MARK: -FOOTER
                Button {
                    isHomeActive = true
                } label: {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                        .imageScale(.large)
                    
                    Text("Restart")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)

        }
    }
}

#Preview {
    HomeView()
}

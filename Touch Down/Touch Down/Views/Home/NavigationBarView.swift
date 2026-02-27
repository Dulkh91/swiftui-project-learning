//
//  NavigationBarView.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

struct NavigationBarView: View {
    //MARK: - PROPERTIES
    @State private var isAnimate: Bool = false
    //MARK: - BODY
    var body: some View {
        HStack{
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            }//: BUTTON
            Spacer()
            LogoView()
                .opacity(isAnimate ? 1 : 0)
                .offset(x:0, y: isAnimate ? 0 : -25)
                .onAppear(){
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimate.toggle()
                    }
                }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Circle()
                        .frame(width: 15,alignment: .center)
                        .foregroundColor(.red)
                        .offset(x: 13, y: -10)
                }
            }//: BUTTON


        }//: HSTACK
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationBarView()
        .padding()
}

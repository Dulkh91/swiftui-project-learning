//
//  TopPathDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct TopPathDetailView: View {
    //MARK: - PROPERTY
    @State private var isAnimation: Bool = false
    
    //MARK: - BODY
    var body: some View {
        HStack{
        //PRICE
            VStack(alignment: .leading) {
                Text("Price")
                    .fontWeight(.semibold)
                    
                Text("\(sampleProducts.formattedPrice)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .scaleEffect(1.35, anchor: .leading)
            }//: Vstack
            .offset(x:0 ,y: isAnimation ? -50 : -75)
            
            Spacer()
            
        //PHOTO
            Image("\(sampleProducts.image)")
                .resizable()
                .scaledToFit()
                .offset(y: isAnimation ? 0: -35)
        
        }//: HStack
        .onAppear {
            withAnimation(Animation.easeOut(duration: 0.75)) {
                self.isAnimation.toggle()
            }
        }
    }
}
//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    TopPathDetailView()
        .padding()
}

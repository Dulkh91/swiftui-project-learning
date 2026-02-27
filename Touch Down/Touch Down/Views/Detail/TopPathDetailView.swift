//
//  TopPathDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct TopPathDetailView: View {
    //MARK: - PROPERTY
    @EnvironmentObject var shop: Shop
    @State private var isAnimation: Bool = false
    
    //MARK: - BODY
    var body: some View {
        HStack(alignment: .center, spacing: 6){
        //PRICE
            VStack(alignment: .leading, spacing: 6) {
                Text("Price")
                    .fontWeight(.semibold)
                    
                Text("\(shop.selectedProduct?.formattedPrice ?? sampleProducts.formattedPrice)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .scaleEffect(1.35, anchor: .leading)
            }//: Vstack
            .offset(x:0 ,y: isAnimation ? -50 : -75)
            
            Spacer()
            
        //PHOTO
            Image("\(shop.selectedProduct?.image ??  sampleProducts.image)")
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
        .environmentObject(Shop())
        .padding()
}

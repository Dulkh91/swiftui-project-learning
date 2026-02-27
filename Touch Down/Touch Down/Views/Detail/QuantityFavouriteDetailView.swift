//
//  QuantityFavouriteDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct QuantityFavouriteDetailView: View {
    //MARK: - PROPERTY
    @State private var count: Int = 0
    //MARK: - BODY
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Button {
                if count > 0 {
                    feetback.impactOccurred()
                    count -= 1
                }
            } label: {
                Image(systemName: "minus.circle")
                
            }
            
            
            Text("\(count)")
                .fontWeight(.semibold)
                .frame(minWidth: 36)
            
            
            Button {
                if count < 100 {
                    feetback.impactOccurred()
                    count += 1
                }
            } label: {
                Image(systemName: "plus.circle")
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "heart.circle")
                    .foregroundColor(Color.red)
            }


        }//: HSTACK
        .font(.title)
        .foregroundColor(.black)
        .imageScale(.large)
    }
}

//MARK: - PREVIEW

#Preview(traits: .sizeThatFitsLayout) {
    QuantityFavouriteDetailView()
        .padding()
}

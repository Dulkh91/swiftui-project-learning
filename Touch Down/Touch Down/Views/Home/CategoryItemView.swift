//
//  CategoryItemView.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

struct CategoryItemView: View {
    let category: CategoryModel
    var body: some View {
        Button {
            
        } label: {
            HStack(alignment: .center, spacing: 6) {
                Image(category.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                
                Text(category.name.uppercased())
                    .fontWeight(.light)
        
                Spacer()
            }//: HSTACK
            .foregroundColor(Color.gray)
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
            )
        }//: Button

    }
}

#Preview(traits: .sizeThatFitsLayout){
    CategoryItemView(category: categories[0])
        .padding()
        .background(.gray)
}

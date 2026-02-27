//
//  BrandItemView.swift
//  Touch Down
//
//  Created by Ros Dul on 25/2/26.
//

import SwiftUI

struct BrandItemView: View {
    @State var brand: BrandModel
    var body: some View {
        Image(brand.image)
            .resizable()
            .scaledToFit()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray,lineWidth: 1)
            )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BrandItemView(brand: brands[0])
        .padding()
}

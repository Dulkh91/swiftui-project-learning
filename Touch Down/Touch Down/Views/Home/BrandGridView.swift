//
//  BrandGridView.swift
//  Touch Down
//
//  Created by Ros Dul on 25/2/26.
//

import SwiftUI

struct BrandGridView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHGrid(rows: gridLayout, content: {
                ForEach(brands){brand in
                    BrandItemView(brand: brand)
                }
            })//: LazyH
            .frame(height: 200)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BrandGridView()
}

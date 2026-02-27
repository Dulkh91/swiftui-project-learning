//
//  CategoryGridView.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

struct CategoryGridView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridLayout,
                      alignment: .center,
                      spacing: columnSpacing) {
                
                Section(header: SectionView(rotationWise: true),
                        footer: SectionView(rotationWise: false)) {
                    ForEach(categories){category in
                        CategoryItemView(category: category)
                    }
                }//: SECTION
                
            }//: LazyHGrid
                      .frame(height: 130)
                      .padding(.horizontal,15)
                      .padding(.vertical, 10)
    
        }//:Scroll
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CategoryGridView()
        .padding()
        .background(.gray)
}

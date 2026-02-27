//
//  TitleView.swift
//  Touch Down
//
//  Created by Ros Dul on 25/2/26.
//

import SwiftUI

struct TitleView: View {
    @State var title: String
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TitleView(title: "Helmet")
        .padding()
}

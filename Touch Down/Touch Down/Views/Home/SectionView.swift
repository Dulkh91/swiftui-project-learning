//
//  SectionView.swift
//  Touch Down
//
//  Created by Ros Dul on 25/2/26.
//

import SwiftUI

struct SectionView: View {
    @State var rotationWise: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("Categories".uppercased())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: rotationWise ? 90 : -90))
            
            Spacer()
            
        }
        .background(colorGray.cornerRadius(12))
        .frame(width: 85)
    }
}

#Preview(traits: .fixedLayout(width: 120, height: 240)) {
    SectionView(rotationWise: true)
        .padding()
}

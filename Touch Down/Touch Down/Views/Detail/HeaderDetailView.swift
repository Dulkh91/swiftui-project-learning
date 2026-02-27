//
//  HeaderDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct HeaderDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Protective Gear")
            
            Text(sampleProducts.name)
                .font(.largeTitle)
                .fontWeight(.black)
            
        }
        .foregroundColor(.white)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HeaderDetailView()
        .padding()
        .background(Color.gray)
        
}

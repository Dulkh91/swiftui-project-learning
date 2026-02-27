//
//  LogoView.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("ros".uppercased())
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image(systemName: "person.fill")
                .font(.title)
            
            Text("Dul".uppercased())
                .font(.largeTitle)
                .fontWeight(.bold)
            
                
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LogoView()
        .padding()
}

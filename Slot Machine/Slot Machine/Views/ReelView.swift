//
//  RealView.swift
//  Slot Machine
//
//  Created by Ros Dul on 3/3/26.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

#Preview(traits: .fixedLayout(width: 220, height: 220)) {
    ReelView()
        .padding()
}

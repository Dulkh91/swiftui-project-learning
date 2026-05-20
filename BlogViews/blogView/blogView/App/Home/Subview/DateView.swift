//
//  DateView.swift
//  blogView
//
//  Created by Ros Dul on 20/5/26.
//

import SwiftUI

struct DateView: View {
    let createdAt: Date
    var body: some View {
        HStack{
            Image(systemName: "calendar")
            Text(formatter.string(from: createdAt))
                .font(.system(.body, design: .default))
               
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    DateView(createdAt: Date())
}

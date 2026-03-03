//
//  FormRowView.swift
//  TodoDemo
//
//  Created by Ros Dul on 2/3/26.
//

import SwiftUI

struct FormRowView: View {
    //MARK: - PROPERTY'
    var icon: String
    var firstTitle: String
    var secondTitle: String
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            .frame(width: 36,height: 36, alignment: .center)
            
            Text(firstTitle).foregroundColor(.gray)
                Spacer()
            Text(secondTitle)
        }
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    FormRowView(icon: "gear", firstTitle: "Application", secondTitle: "Todo")
        .padding()
}

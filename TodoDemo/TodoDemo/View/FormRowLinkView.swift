//
//  FormRowLinkView.swift
//  TodoDemo
//
//  Created by Ros Dul on 2/3/26.
//

import SwiftUI

struct FormRowLinkView: View {
//MARK: - PROPERTY
    var icon: String
    var color: Color
    var title: String
    var link: String
    
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36,alignment: .center)
            
            Text(title)
            Spacer()
            
            Button {
                guard let url = URL(string: self.link),
                      UIApplication.shared.canOpenURL(url) else{return}
                
                UIApplication.shared.open(url as URL)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold ,design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }
    }
}

//MARK: - PREVIW
#Preview(traits: .fixedLayout(width: 376, height: 70)) {
    FormRowLinkView(icon: "globe", color: .purple, title: "website", link: "www.it-dul.blogspot.com")
        .padding()
}

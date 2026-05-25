//
//  ImageView.swift
//  profileTelegrame
//
//  Created by Ros Dul on 23/5/26.
//

import SwiftUI

struct ImageView: View {
    //MARK: - PROPERTY
    var size: CGFloat = 100
    var imageShap: AnyShape = .init(.circle)
    
    //MARK: - BODY
    var body: some View {
            let urlLink:String? =  "https://avatars.githubusercontent.com/u/143316945"
            if let imageLink = urlLink,
              let url = URL(string: imageLink){
                AsyncImage(url: url) { img in
                    img.resizable()
                        .scaledToFit()
                        .frame(width: size, height: size, alignment: .center)
                        .clipShape(imageShap)
                } placeholder: {
                    Text("Dul")
                        .frame(width: size, height: size)
                        .font(.system(size: size * 0.4))
                        .background(Color.yellow)
                        .clipShape(imageShap)
                        .foregroundColor(.white)
                }
            }
    }
}

#Preview {
    ImageView()
}

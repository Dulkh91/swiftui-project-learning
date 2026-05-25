//
//  ImageProfileView.swift
//  blogView
//
//  Created by Ros Dul on 20/5/26.
//

import SwiftUI

struct ImageProfileView: View {
    let author: Author
    var size: CGFloat = 60
    
    var body: some View {
        
        if let imageUrl = author.image,
           let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image.resizable()
                     .scaledToFill()
                     .frame(width: size, height: size)
                     .clipShape(Circle())
            } placeholder: {
                placeholderView
            }
        } else {
            placeholderView
        }
    }
    
    
    private var placeholderView: some View{
        let name = nameSort(name: author.username)
        
        return Text(name)
            .font(.system(size: size * 0.4))
            .frame(width: size, height: size)
            .background(
                LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Circle())
            .foregroundColor(.white)
        
    }
    
    func nameSort(name: String) ->String{
        let title = name.prefix(1)
        return title.capitalized
    }
}



#Preview {
    let sampleArticle = BlogViewsModel(
        slug: "sample",
        title: "Sample Title",
        description: "Sample Description",
        body: "Sample body",
        tagList: [],
        createdAt: Date(),
        updatedAt: Date(),
        favorited: false,
        favoritesCount: 0,
        author: Author(username: "sampleuser", bio: nil, image: nil, following: false)
    )
    return ImageProfileView(author: sampleArticle.author)
}

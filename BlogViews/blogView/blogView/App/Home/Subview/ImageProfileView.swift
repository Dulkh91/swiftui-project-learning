//
//  ImageProfileView.swift
//  blogView
//
//  Created by Ros Dul on 20/5/26.
//

import SwiftUI

struct ImageProfileView: View {
    let author: Author
    var body: some View {
        
        if let imageUrl = author.image,
           let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image.resizable()
                     .scaledToFill()
                     .frame(width: 60, height: 60)
                     .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person.slash.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }
        } else {
            Image(systemName: "person.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
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

//
//  ArticleRowView.swift
//  blogView
//
//  Created by Ros Dul on 22/5/26.
//

import SwiftUI

struct ArticleRowView: View {
    let article: BlogViewsModel
    var body: some View {
        HStack(alignment: .top){
            ImageProfileView(author: article.author)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    
                    // date view
                    DateView(createdAt: article.createdAt)
                    
                    Text(article.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }// - vstack
                
            }// - hstack

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
    
}




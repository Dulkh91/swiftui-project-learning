//
//  DetailListView.swift
//  blogView
//
//  Created by Ros Dul on 22/5/26.
//

import SwiftUI

struct DetailListView: View {
    var articleDetail: BlogViewsModel
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                Text(articleDetail.title)
                    .font(.title)
                    .foregroundColor(.accentColor)
                
                DateView(createdAt: articleDetail.createdAt)
                
                Text(articleDetail.description)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                Text(articleDetail.body)
                    .font(.callout)
                    .foregroundColor(.gray)
            }// - Vstack
            .frame(maxWidth: .infinity, alignment: .leading)
        }// - scrollView
        .padding()
        
        .toolbar{
            ToolbarItem (placement: .principal){
                TitleBarView(
                    author: articleDetail.author
                )
                
            }

        }// - toolbar
        
    }// - BODY
}

struct TitleBarView: View{
    let author: Author
    var body: some View{
        HStack{
            ImageProfileView(author: author)
            
            Text(author.username)
        }
        
    }
}

#Preview {
    let detailArticle = BlogViewsModel(slug: "abc",
                                       title: "ab",
                                       description: "ab",
                                       body: "ab",
                                       tagList: ["String?"],
                                       createdAt: Date(),
                                       updatedAt: Date(),
                                       favorited: false,
                                       favoritesCount: 0,
                                       author: Author(username: "dul",
                                                      bio: nil,
                                                      image: nil,
                                                      following: false))
    DetailListView(articleDetail: detailArticle)
}

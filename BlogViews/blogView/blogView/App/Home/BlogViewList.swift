//
//  HomeView.swift
//  blogView
//
//  Created by Ros Dul on 19/5/26.
//

import SwiftUI
import Combine

@MainActor
final class BlogViewModel: ObservableObject{
    @Published var blogViewArticle: [BlogViewsModel] = []
    
    func getArtiles() async{
        do{
            let articlesResponse = try await Services.shared.getBlogViews()
            self.blogViewArticle = articlesResponse
        } catch {
            print("❌ Error: \(error.localizedDescription)")
        }
    }
    
}

struct BlogViewList: View {
    //MARK: - PROPERTY
    @StateObject private var vm = BlogViewModel()
    
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            List (vm.blogViewArticle, id: \.slug){ article in
                
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
            }// - List
            .navigationTitle("Blog view list")
            .task {
                await vm.getArtiles()
            }
        }
    }
}

#Preview {
    BlogViewList()
}

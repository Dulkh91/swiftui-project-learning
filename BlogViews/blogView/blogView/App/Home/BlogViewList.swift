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
    
    func getArticles() async {
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
    @State private var cancellables = Set<AnyCancellable>()
//    @State private var pollingTask: Task<Void,Never>?
    
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            List (vm.blogViewArticle, id: \.slug){ article in
                
                NavigationLink {
                    DetailListView(articleDetail: article)
                } label: {
                    ArticleRowView(article: article)
                }

                
                    
            }// - List
            .navigationTitle("Blog view list")
            .task {
                await vm.getArticles()

                // Poll every 30 seconds without making the task closure throwing
                let ticker = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
                for await _ in ticker.values {
                    await vm.getArticles()
                }
            }
            
        }// - Navigation
    
    }// - Body
    
}


#Preview {
    BlogViewList()
}


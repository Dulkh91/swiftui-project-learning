//
//  Services.swift
//  blogView
//
//  Created by Ros Dul on 19/5/26.
//

import Foundation
import Combine


class Services{
    static var shared = Services()
    init() {}
    
    private let my_token = Secrets.blogAPIKey
    private let url_api = "https://realworld.habsida.net/api/articles"
    
    private var cancellables = Set<AnyCancellable>()
    
    func getBlogViews() async throws -> [BlogViewsModel]{
        guard let url = URL(string: url_api) else{
            throw URLError(.badURL)
        }
        
        // បង្កើត URLRequest ជំនួស URL ធម្មតា
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // បន្ថែម Token នៅ Header
        request.setValue("Bearer \(my_token)", forHTTPHeaderField: "Authorization")
        
        // ប្រើ request ជំនួស url
        let (data, responce) = try await URLSession.shared.data(for: request)
        
        guard let htpResponce = responce as? HTTPURLResponse,
              (200..<300).contains(htpResponce.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
//        let decode = try JSONDecoder().decode(BlogResponse.self, from: data)
        let decode = try decoder.decode(BlogResponse.self, from: data)
        return decode.articles
    }
}


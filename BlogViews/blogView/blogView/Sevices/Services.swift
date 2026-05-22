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
    
    private let url_api = "https://realworld.habsida.net/api/articles"
    private let my_token = Secrets.blogAPIKey
    
    
    // Decoder of date
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    
    // Delegate URL
    private var apiUrl: URL{
        get throws {
            guard let url = URL(string: url_api) else{
                throw URLError(.badURL)
            }
            
            return url
        }
    }
    
    func getBlogViews() async throws -> [BlogViewsModel]{

       let url = try apiUrl
        
        // បង្កើត URLRequest ជំនួស URL ធម្មតា
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // បន្ថែម Token នៅ Header
        request.setValue("Bearer \(my_token)", forHTTPHeaderField: "Authorization")
        
        // ប្រើ request ជំនួស url
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let htpResponse = response as? HTTPURLResponse,
              (200..<300).contains(htpResponse.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let decode = try decoder.decode(BlogResponse.self, from: data)
        return decode.articles
    }
    
    
    
    func getBlogViewDetail (slot: String) async throws->[BlogViewsModel]{
        
        // យក absoluteString មកបូកជាមួយ slot រួចបង្កើតជា URL ថ្មី is suport old iphone
//        guard let urlSlot = URL(string: "\(url.absoluteString)/\(slot)") else {
//            throw URLError(.badURL)
//        }
        
        guard !slot.isEmpty else {
            throw URLError(.badURL)
        }
        let url = try apiUrl
        let urlSlot = url.appending(path: slot)// new method suport new device
        
        var request = URLRequest(url: urlSlot)
        request.httpMethod = "GET"
        
        // បន្ថែម Token នៅ Header
        request.setValue("Bearer \(my_token)", forHTTPHeaderField: "Authorization")
        
        // ប្រើ request ជំនួស url
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let htpResponse = response as? HTTPURLResponse,
              (200..<300).contains(htpResponse.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let decode = try decoder.decode(BlogResponse.self, from: data)
        return decode.articles
        
        
    }
    
    
}


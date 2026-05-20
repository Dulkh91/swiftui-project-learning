//
//  ApiDatabase.swift
//  blogView
//
//  Created by Ros Dul on 19/5/26.
//

import Foundation

struct BlogResponse: Codable {
    let articles: [BlogViewsModel]
}

struct BlogViewsModel: Codable {
    let slug: String
    let title: String
    let description: String
    let body: String
    let tagList: [String?]   // because JSON has null
    let createdAt: Date    // easier: keep as String, then convert to Date later
    let updatedAt: Date
    let favorited: Bool
    let favoritesCount: Int
    let author: Author
}


struct Author: Codable {
    let username: String
    let bio: String?
    let image: String?
    let following: Bool
}



// FORMAT API
/*
 {
 "articles": [
         {
             "slug": "former-studied",
             "title": "Former studied",
             "description": "I was study ",
             "body": "I stay at home with unemployed ",
             "tagList": [
                 null
             ],
             "createdAt": "2026-05-15T02:21:51.000Z",
             "updatedAt": "2026-05-15T02:21:51.000Z",
             "favorited": false,
             "favoritesCount": 0,
             "author": {
                 "username": "duldul",
                 "bio": "",
                 "image": null,
                 "following": false
             }
         },
         {
             "slug": "hihi",
             "title": "HiHi",
             "description": "HiHi",
             "body": "HiHiHi",
             "tagList": [
                 "hi"
             ],
             "createdAt": "2026-04-27T23:04:32.000Z",
             "updatedAt": "2026-04-27T23:04:32.000Z",
             "favorited": false,
             "favoritesCount": 2,
             "author": {
                 "username": "in94",
                 "bio": "",
                 "image": null,
                 "following": false
             }
         },
 
 ...
 }
 */

//
//  CategoryModel.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import Foundation
struct CategoryModel: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}


/*
 
 {
   "id" : 1,
   "name" : "Helmet",
   "image" : "icon-helmet"
 }
 
 */

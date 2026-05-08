//
//  ProductDatabase.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Identifiable, Codable, Equatable {
    let id: Int
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case images
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
}


//    func downloadProductAndUploadToFirebase(){
//        guard let url = URL(string: "https://dummyjson.com/products")else{return}
//
//        Task{
//            do{
//                let request = URLRequest(url: url)
//                let (data, _) = try await URLSession.shared.data(for: request)
//                let products = try JSONDecoder().decode(ProductArray.self, from: data)
//
//                let productArray = products.products
//
//                for product in productArray{
//                    try await ProductManager.share.uploadProduct(product: product)
//
//                }
//
//                print("SUCCESS")
//                print(products.products.count)
//            }catch{
//                print(error)
//            }
//        }
//
//    }



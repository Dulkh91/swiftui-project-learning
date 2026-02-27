//
//  ProductModel.swift
//  Touch Down
//
//  Created by Ros Dul on 25/2/26.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    let id: Int
    let name: String
    let image: String
    let price: Int
    let description: String
    let color: [Double]
    
    // Create computed property
    var red: Double {return color[0]}
    var green: Double {return color[1]}
    var blue: Double {return color[2]}
    
    var formattedPrice: String {return "$\(price)"}
}


/*
 {
   "id" : 1,
   "name" : "Blue helmet",
   "image" : "helmet-no6",
   "price" : 199,
   "description" : "The football helmet is a piece of protective equipment used mainly in gridiron football. It consists of a hard plastic shell with thick padding on the inside, a face mask made of one or more plastic-coated metal bars, and a chinstrap. Each position has a different type of face mask to balance protection and visibility, and some players add polycarbonate visors to their helmets, which are used to protect their eyes from glare and impacts. Helmets are a requirement at all levels of organized football.",
   "color" : [
     0.61,
     0.8,
     0.89
   ]
 },
 ....
 
 */

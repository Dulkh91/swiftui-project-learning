//
//  Shop.swift
//  Touch Down
//
//  Created by Ros Dul on 27/2/26.
//

import Foundation
internal import Combine

class Shop: ObservableObject{
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: ProductModel? = nil
}

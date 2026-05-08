//
//  ProductView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import SwiftUI
internal import Combine

@MainActor
final class ProductViewModel: ObservableObject {
        

}

struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    var body: some View {
        ZStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("Product")
        
        
    }
}

#Preview {
    ProductView()
}

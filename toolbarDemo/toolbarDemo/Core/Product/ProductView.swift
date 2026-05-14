//
//  ProductView.swift
//  toolbarDemo
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        List {
            ForEach(1..<11, id: \.self){index in
                Text("Hello \(index)")
                    .padding()
            }
            
            .navigationTitle("List")
        }
        .listStyle(.automatic)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "line.3.horizontal.decrease")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "plus.square.fill")
            }
        }
        
    }
}

#Preview {
    NavigationStack{
        ProductView()
    }
}

//
//  ContentView.swift
//  ImageDemo
//
//  Created by Ros Dul on 12/2/26.
//

import SwiftUI

//subview
extension Image{
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    func iconModified() -> some View {
        self
        .resizable()
        .scaledToFit()
        .frame(width: 300)
        .foregroundColor(.purple)
    }
}

struct ContentView: View {
    private var imageURL: String = "https://media.istockphoto.com/id/2080330458/photo/kep-sunset.jpg?s=612x612&w=0&k=20&c=rYeRXoV58jl10Wrw8-x7QNYI7JqrP7hIFD_SHf3uYaw="
    
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()
            
            /*
            AsyncImage(url: URL(string: imageURL)) { image in
                image.imageModifier()
            } placeholder: {
                Image(systemName: "photo.circle.fill").iconModified()
            }
             
             */
            
            AsyncImage(url: URL(string: imageURL),transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))){ phase in
                switch phase {
                case.success(let image):
                    image
                        .imageModifier()
                        .transition(.scale)
                    
                case.failure(_):
                    Image(systemName: "ant.circle.fill")
                        .iconModified()
                case .empty:
                    Image(systemName: "photo.circle.fill")
                        .iconModified()
                @unknown default:
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity)
        }
        
         
    }
    
    private var backgroundColor: some View {
        RadialGradient(colors: [.purple,.blue], center: .topLeading, startRadius: 10, endRadius: 500)
    }
}





#Preview {
    ContentView()
}

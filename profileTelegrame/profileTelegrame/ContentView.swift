//
//  ContentView.swift
//  profileTelegrame
//
//  Created by Ros Dul on 23/5/26.
//

import SwiftUI

struct ContentView: View {
    private let imageHeight: CGFloat = 360
    
    var body: some View {
        ZStack {
            ScrollView(.vertical){
                VStack(spacing: 0){
                    GeometryReader { geo in
                        let minY = geo.frame(in: .global).minY
                        let offsetY = minY > 0 ? -minY : 0
                        // តំលៃ zoom
                        
                        let zoomScale = minY < 0 ? 1 + (-minY / imageHeight) : 1
                        
//                       let _ = print("zoomScal\(zoomScale)")
                        
//                        let _ = print("minY: \(minY)")
                        // ប្តូររូបរាងពេល zoom
                        let shouldBecircle = zoomScale > 1.0
                        let currentShape: AnyShape = shouldBecircle ? .init(.circle) : .init(.rect)
                        
                        
                        // រកចំណុចកណ្តាល
                        let screenWidth = geo.size.width
                        
                        ImageView(
//                            size:  imageHeight / zoomScale,
                            size:  zoomScale > 1.0 ? 100 :  imageHeight,
                            imageShap: currentShape
                            
                        )
                    
                        // ធ្វើឱ្យរូបភាពរលាស់ទៅតាមការអូស (Parallax Zoom)
                            .offset(y: offsetY)
                            .frame(
                                width: screenWidth,
                                height: imageHeight + (minY > 0 ? minY : 0)
                            
                            )
                        
                            .clipped()
                            .animation(.easeOut(duration: 0.3), value: shouldBecircle)
                    }// - geo
                    .frame(height: imageHeight)
                    .zIndex(1)
                }// - vstack
                .padding()
            }// - scroll
            
        }
//        .coordinateSpace(name: "scroll")// if want to use padding at this shound use this
//        .padding()
    }
}

#Preview {
    ContentView()
}

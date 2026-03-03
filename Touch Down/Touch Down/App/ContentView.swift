//
//  ContentView.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPETIES
     @EnvironmentObject var shop: Shop
    
    //MARK: - BODY
    var body: some View {
            GeometryReader {geo in
                
                    ZStack {
                        if shop.showingProduct == false && shop.selectedProduct == nil{
                        VStack(spacing: 0) {
                            NavigationBarView()
                                .padding(.horizontal, 15)
                                .padding(.bottom)
                                .padding(.top, geo.safeAreaInsets.top)
                                .background(.white)
                                .shadow(color: .black.opacity(0.05), radius: 5,x:0,y:5)
                            
                            ScrollView {
                                VStack(spacing: 0) {
                                    FeaturedTabView()
                                    
                                    CategoryGridView()
                                    
                                    TitleView(title: "Helmates")
                                    
                                    LazyVGrid(columns: gridLayout, spacing: 15) {
                                        ForEach(products){product in
                                            ProductView(product: product)
                                                .onTapGesture {
                                                    feetback.impactOccurred()
                                                    withAnimation(.spring) {
                                                        shop.selectedProduct = product
                                                        shop.showingProduct = true
                                                    }
                                                }
                                        }
                                    }//: LazyVGrid
                                    .padding()
                                    
                                    TitleView(title: "Brands")
                                    BrandGridView()
                                    
                                    FooterView()
                                        .padding(.horizontal)
                                    
                                }//: VSTACK
                            }//: SCROLL
                            
                        }//: VSTACK
                        .background(colorBackground.ignoresSafeArea(.all))
                        
                        }else{
                            ProductDetailtView()
                        }
                    }//: ZSTACK
                    .ignoresSafeArea(.all, edges: .top)
                
                
            }//: GeometryReader
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
        .environmentObject(Shop())
}

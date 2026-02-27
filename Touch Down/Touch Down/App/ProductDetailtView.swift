//
//  ProductDetailtView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct ProductDetailtView: View {
    //MARK: - PROPERTY
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .center){
                VStack(alignment: .leading, spacing: 0){
                    //Navibar
                    NavigationBarDetailView()
                        .padding()
                        .padding(.top, geo.safeAreaInsets.top)
                    //Header
                    HeaderDetailView()
                        .padding(.horizontal)
                    
                    //Detail Top Part
                    TopPathDetailView()
                        .zIndex(1)
                        .padding(.horizontal)
                    
                    
                    //Detail Bottom Part
                    VStack{
                        //Rating + Size
                         RatingSizeDataView()
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        //Description
                        ScrollView(.vertical, showsIndicators: false){
                            Text(sampleProducts.description)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                    
                        }//: ScrollView
                        
                        //Quatity + Favourite
                        QuantityFavouriteDetailView()
                            .padding(.vertical, 10)
                        //Add to card
                        AddToCartDetailView()
                            .padding(.bottom, 20)
                        
                        Spacer()
                        
                    }//: Vstack
                    .padding(.horizontal)
                    //.padding(.top, -30)
                    .background(
                        Color
                            .white
                            .clipShape(CustomShape())
                            .padding(.top, -110)
                            .padding(.bottom, -20)
                    )
        
                    Spacer()
                }//: Vstack
                .zIndex(0)
                .ignoresSafeArea()
                .background(
                    Color(red: sampleProducts.red,
                          green: sampleProducts.green,
                          blue: sampleProducts.blue))
                .ignoresSafeArea(.all, edges: .all)
            }//: ZSTACK
            .frame(width: geo.size.width)
        }//: GEO
    }
}

//MARK: - PREVIEW
#Preview(traits: .fixedLayout(width: 375, height: 812)) {
    ProductDetailtView()
}

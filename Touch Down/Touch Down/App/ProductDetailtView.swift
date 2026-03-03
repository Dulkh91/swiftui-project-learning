//
//  ProductDetailtView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct ProductDetailtView: View {
    //MARK: - PROPERTY
    @EnvironmentObject var shop: Shop
    //MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .center){
                VStack(alignment: .leading, spacing: 6){
                    //Navibar
                    NavigationBarDetailView()
                        .zIndex(2)
                        .padding()
                        .padding(.top, geo.safeAreaInsets.top + 20)
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
                            Text(shop.selectedProduct?.description ?? sampleProducts.description)
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
                    Color(red: shop.selectedProduct?.red ?? sampleProducts.red,
                          green: shop.selectedProduct?.green ?? sampleProducts.green,
                          blue: shop.selectedProduct?.blue ?? sampleProducts.blue))
                .ignoresSafeArea(.all, edges: .all)
            }//: ZSTACK
            .frame(width: geo.size.width)
        }//: GEO
    }
}

//MARK: - PREVIEW
#Preview {
    ProductDetailtView()
        .environmentObject(Shop())
}

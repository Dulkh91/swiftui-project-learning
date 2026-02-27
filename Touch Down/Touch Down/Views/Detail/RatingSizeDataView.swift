//
//  RatingSizeDataView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct RatingSizeDataView: View {
    //MARK: - PROPERTY
    
    let sizes:[String] = ["xs","s","m","l","xl"]
    
    //MARK: - BODY
    var body: some View {
        HStack {
        // RATING
            VStack(alignment: .leading, spacing: 10) {
                Text("Ratings")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                
                HStack{
                    ForEach(1...5, id: \.self){ item in
                        Button {
                            
                        } label: {
                            Image(systemName: "star.fill")
                                .frame(width: 28,height: 28, alignment: .center)
                                .background(Color.gray.cornerRadius(5))
                                .foregroundColor(Color.white)
                        }

                    }
                }//: HSTACK
            }//: VSTACK
            
            Spacer()
            
        // SIZES
            VStack(alignment: .leading, spacing: 10) {
                Text("Sizes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                
                HStack{
                    ForEach(sizes, id: \.self){ size in
                        Button {
                            
                        } label: {
                            Text(size.uppercased())
                                .font(.footnote)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.gray)
                                .frame(width: 28, height: 28, alignment: .center)
                                .background(Color.white.cornerRadius(5))
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                            
                        }

                    }
                }//: HSTACK
            }//: VSTACK
            
        }//: HSTACK
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    RatingSizeDataView()
        .padding()
}

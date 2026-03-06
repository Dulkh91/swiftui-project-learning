//
//  InforView.swift
//  Slot Machine
//
//  Created by Ros Dul on 3/3/26.
//

import SwiftUI

struct InforView: View {
    //MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode
    //MARK: - BODY
    var body: some View {
        VStack {
            LogoView()
            Spacer()
            
            List{
                Section {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "iPhone / iPad / Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Dul")
                    FormRowView(firstItem: "Designer", secondItem: "Dinna / Dul")
                    FormRowView(firstItem: "Website", secondItem: "itdul.blogspot.com")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                    
                }header: {
                    Text("About the application")
                }//: SECTION
                
            }//: FORM
            .font(.system(.body, design: .rounded))
            .listStyle(.grouped)
        }//: VSTACK
        .padding(.top, 5)
        .overlay(alignment: .topTrailing) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .padding(.top, 10)
                    .padding(.trailing, 15)
                    .foregroundColor(.gray)
            }

        }
    }
}

struct FormRowView: View {
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

#Preview {
    InforView()
}

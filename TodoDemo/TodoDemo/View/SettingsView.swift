//
//  SettingsView.swift
//  TodoDemo
//
//  Created by Ros Dul on 2/3/26.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                //MARK: - FORM
                Form{
                    //MARK: - SECTION 3
                    Section{
                        FormRowLinkView(icon: "globe", color: .purple, title: "Website", link: "https://itdul.blogspot.com/")
                        FormRowLinkView(icon: "link", color: .green, title: "Twitter", link: "https://x.com/")
                    }header: {
                        Text("Follow us on social media")
                    }
                    
                    //MARK: - SECTION 4
                    Section {
                        FormRowView(icon: "gear", firstTitle: "Application", secondTitle: "Todo")
                        FormRowView(icon: "checkmark.seal", firstTitle: "Compatibility", secondTitle: "iPhone, iPad")
                        FormRowView(icon: "keyboard", firstTitle: "Developer", secondTitle: "Dul / Ros")
                        FormRowView(icon: "paintbrush", firstTitle: "Designer", secondTitle: "Rebert")
                        FormRowView(icon: "flag", firstTitle: "version", secondTitle: "1.0.0")
                    } header: {
                        Text("About the application")
                    }

                    
                    
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)//size iPhone
                
                //MARK: - FOOTER
                Text("Copyright  All rights reserved.\nBetter Apps lesscode")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.top, 6)
                    .padding(.bottom, 10)
                    .foregroundColor(Color.secondary)
            }//: Vstack
            .navigationTitle("Setting")
            .background(Color("ColorBackground").ignoresSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
                
            }
        }//: Navigation
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

#Preview {
    SettingsView()
}

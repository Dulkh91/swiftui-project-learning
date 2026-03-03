//
//  EmptyListView.swift
//  TodoDemo
//
//  Created by Ros Dul on 1/3/26.
//

import SwiftUI

struct EmptyListView: View {
    //MARK: - PROPERTY
    @State private  var isAnimate: Bool = true
    //MARK: - BODY
    var body: some View {
        ZStack{
            VStack {
                Image("illustration-no1")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        minWidth: 256,
                        idealWidth: 280,
                        maxWidth: 360,
                        minHeight: 256,
                        idealHeight: 280,
                        maxHeight: 360,
                        alignment: .center
                    )
                    .layoutPriority(1)
                
                Text("Use your time wisely")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }//: Vstack
            .padding(.horizontal)
            .opacity(isAnimate ? 0 : 1)
            .offset(y: isAnimate ? 0 : -50)
            .onAppear {
                withAnimation(Animation.easeOut(duration: 1.5)) {
                    self.isAnimate.toggle()
                }
            }
        }//: Zstack 
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity
            )
            .background(Color("ColorBase"))
            .ignoresSafeArea(.all)
            
    }
}

#Preview {
    EmptyListView()
        .environment(\.colorScheme, .dark)
}

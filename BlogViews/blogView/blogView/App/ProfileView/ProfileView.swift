//
//  ProfileView.swift
//  blogView
//
//  Created by Ros Dul on 22/5/26.
//

import SwiftUI

struct ProfileView: View {
    var auth: Author
    var body: some View {
        ScrollView {
            VStack{
                ImageProfileView(author: auth, size: 150 )
                
                Text(auth.username)
                    .font(.system(size: 50).bold())
            }// - vstack
            
            
            List{
                VStack(alignment: .leading){
                    Text("Bio")
                }
            }
        }// - srollView
    }
}

#Preview {
    ProfileView(auth: Author(username: "dul",
                             bio: nil,
                             image: nil,
                             following: false))
}

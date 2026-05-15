//
//  FavoriteView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI
import Combine

final class FavouriteViewModel: ObservableObject{
    @Published private(set) var userFavouriteProducts: [UserFavouriteProduct] = []
    @Published var isLoading = false
    
    func getFavorites(){
           
        Task{
            let authResult = try AuthenticationManager.shared.getAuthenticateUser()
            
            self.userFavouriteProducts = try await UserManager
                .shared.getUserAllFavoriteProduct(userId: authResult.uid)
            
        }
        
    }
    
    func removeFavoriteProduct(favoriteId: String){
        Task{
            let authResult = try AuthenticationManager.shared.getAuthenticateUser()
            try await UserManager.shared.removeUserFavoriteProduct(userId: authResult.uid, favoriteId: favoriteId)
            
            getFavorites()
        }
    }
    
}

struct FavoriteView: View {
    //MARK: - Property
    @StateObject private var viewModel = FavouriteViewModel()
    
    //MARK: - Body
    var body: some View {
        
        List{
            ForEach(viewModel.userFavouriteProducts, id: \.id) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                
                    .contextMenu {
                        Button("Remove from favorite"){
                            viewModel.removeFavoriteProduct(favoriteId: item.id)
                        }
                    }
                    
            }// - forEach

        }// - List
        .navigationTitle("Favorites")
        .onAppear{
            viewModel.getFavorites()
        }
    }
}

#Preview {
    NavigationStack{
        FavoriteView()
    }
    
}

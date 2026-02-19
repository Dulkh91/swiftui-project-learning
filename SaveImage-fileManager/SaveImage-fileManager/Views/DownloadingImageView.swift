//
//  DownloadingImage.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 19/2/26.
//

import SwiftUI
internal import Combine

struct DownloadingImageView: View {
    @StateObject var loader: ImageDownloadingViewModel
    
    init(url: String){
        _loader = StateObject(wrappedValue: ImageDownloadingViewModel(url: url))
    }
    
    var body: some View {
        ZStack{
            if loader.isLoading {
                ProgressView()
            }else if let image = loader.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952")
        .frame(width: 75, height: 75)
}

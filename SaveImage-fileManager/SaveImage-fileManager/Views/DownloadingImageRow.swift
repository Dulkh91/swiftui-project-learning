//
//  DownloadingImageRow.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 19/2/26.
//

import SwiftUI

struct DownloadingImageRow: View {
    let model: PhotoModel
    
    var body: some View {
        HStack{
//            Circle()
            DownloadingImageView(url: model.url)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .font(.caption)
            }
        }
    }
}

#Preview{
    DownloadingImageRow(
        model:
            PhotoModel(
                albumId: 1,
                id: 1,
                title: "title",
                url: "url",
                thumbnailUrl: "thumbnailUrl"
            )
    )
}

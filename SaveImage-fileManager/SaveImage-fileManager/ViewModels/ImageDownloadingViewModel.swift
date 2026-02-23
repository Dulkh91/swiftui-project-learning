//
//  ImageDownloadingViewModel.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 19/2/26.
//

import Foundation
import SwiftUI
internal import Combine

class ImageDownloadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published  var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelCacheManager.instance
    //PhotoModelFileManager.instance
    //PhotoModelCacheManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String){
       urlString = url
        imageKey = key
//        downloadImage()
        getImage()
    }
    
    func getImage(){
        if let saveImage = manager.get(key: imageKey) {
            image = saveImage
            print("Getting save image")
        }else{
            downloadImage()
            print("Download image now!")
        }
    }
    
    func downloadImage(){
        print("Download image now!")
        isLoading = true
        guard let url = URL(string: urlString) else { return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (_) in
                self?.isLoading = false
            } receiveValue: {[weak self] (returnImage) in
                guard
                    let self = self,
                    let image = returnImage else { return }
                
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}


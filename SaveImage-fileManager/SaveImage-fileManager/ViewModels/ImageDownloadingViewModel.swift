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
    
    let urlString: String
    
    init(url: String){
       urlString = url
        downloadImage()
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
                self?.image = returnImage
            }
            .store(in: &cancellables)

            
            
    }
}


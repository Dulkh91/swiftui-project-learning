//
//  DownloadingImageViewModel.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 19/2/26.
//

import Foundation
internal import Combine

class DownloadingImageViewModel: ObservableObject{
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataServer = PhotoModelDataServer.instance
    
    init(){
       addSubScriber()
    }
    
    func addSubScriber(){
        dataServer.$photoModuls
            .sink {[weak self] (returnPhotoModels) in
                self?.dataArray = returnPhotoModels
            }
            .store(in: &cancellables)
    }
    
}


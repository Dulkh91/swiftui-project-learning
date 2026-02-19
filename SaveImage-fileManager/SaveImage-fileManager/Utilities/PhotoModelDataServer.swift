//
//  PhotoModelDataServer.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 19/2/26.
//

import Foundation
import Combine

class PhotoModelDataServer {
    static let instance = PhotoModelDataServer()//singleton
    @Published var photoModuls: [PhotoModel] = []
    var cancellable = Set<AnyCancellable>()
    
    private init() {
        donwload()
    }
    
    func donwload(){
        let URLApi = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: URLApi ) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap (handleOutput) //transform
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())//មើល api ប្រិនមាន [{}] ត្រូវតែដាក់ []
            .sink { completion in
                switch completion{
                case.finished:
                    break
                case.failure(let error):
                    print("Error downoad data \(error)")
                }
            } receiveValue: {[weak self] (returnPhotoModuls) in
                self?.photoModuls = returnPhotoModuls
            }
            .store(in: &cancellable)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output)throws -> Data{
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 300 else{
                throw URLError(.badServerResponse)
            }
            return output.data
    }
    
}

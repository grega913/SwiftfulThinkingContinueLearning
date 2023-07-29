//
//  PhotoModelDataSerivce.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 29/07/2023.
//

import Foundation
import Combine


class PhotoModelDataService {
    
    static let instance = PhotoModelDataService() //Singleton
    
    @Published var photoModels:  [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    //because it is private we are only allowed it to initialized it from here
    private init () {
        print("photoModeldataservice.init")
        downloadData()
    }
    
    func downloadData() {
        print("func downloadData")
        
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/photos" ) else { return }
                
        //download with combine
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data \(error)")
                }
                
            } receiveValue: { [weak self] (returnedPhotoModels) in
                self?.photoModels = returnedPhotoModels
            }
            .store(in: &cancellables)
        

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        
        print("func handleOutput")
        
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
        
    }
    
    
}

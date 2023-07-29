//
//  DownloadingImagesViewModel.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 29/07/2023.
//

import Foundation
import Combine


class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init() {
       addSubscribers()
    }
    
    
    
    // here we are subscribing to published array from PhotoModelDataService
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels) in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}

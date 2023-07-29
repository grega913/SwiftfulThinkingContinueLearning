//
//  DownloadingImagesBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 29/07/2023.
//

// Codable
// background threads
// weak self
// Combine
// Publishers and Followers
// FileManager
// NSCache


import SwiftUI



struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}

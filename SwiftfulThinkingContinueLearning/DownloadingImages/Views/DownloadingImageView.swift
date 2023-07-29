//
//  DownloadingImagesView.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 29/07/2023.
//

import SwiftUI

struct DownloadingImageView: View {
    
    
    //we need to initialize this loader from the init
    //@StateObject var loader = ImageLoadingViewModel()
    @StateObject var loader: ImageLoadingViewModel
    
    init(url:String, key:String) {
        // to initialize StateObject, we use the _
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image{
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                
            }
            
        }
    }
}

struct DownloadingImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url:"https://via.placeholder.com/600/92c952", key: "123")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}

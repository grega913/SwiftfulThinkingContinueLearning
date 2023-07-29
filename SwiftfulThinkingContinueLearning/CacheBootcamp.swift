//
//  CacheBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 29/07/2023.
//

import SwiftUI


/* When creating a NSCache, we need to tell explicitely what type are we gonna be using
 
 
 */

class CacheManager {
    
    static let instance = CacheManager()
    
    // private init - - we can only initialize a manager within a class
    private init () { }
    
    
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        cache.countLimit = 100 //max num of files in cache
        cache.totalCostLimit = 1024 * 1024 * 100 //100MB
        
        
        return cache
    } ()
    
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return ("Added to cache!")
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return ("Removed from cache!")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}



class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    let imageName: String = "raul"
    let manager = CacheManager.instance
    
    
    init () {
        getImageFromAssetsFolder()
    }
    
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        print("fun vm.saveToCache")
        guard let image =  startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache(){
        print("fun vm.removeFromCache")
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache(){
        print("fun vm.getFromCache")
        
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache"
        } else {
          infoMessage = "Image not found in Cache"
        }

    }
    
}





struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height:200)
                        .clipped()
                        .cornerRadius(20)
                }

                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                    
                    HStack {
                        Button(action: {
                            vm.saveToCache()
                            
                        }, label: {
                            Text("Save to Cache")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .padding(.horizontal)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                        
                        Button(action: {
                            vm.removeFromCache()
                        }, label: {
                            Text("Delete from Cache")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .padding(.horizontal)
                                .background(Color.red)
                                .cornerRadius(10)
                        })
                    }
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height:200)
                        .clipped()
                        .cornerRadius(20)
                }
                    
                    Spacer()
                    
                }
                .navigationTitle("File manager")
                
            }
        }
    }


struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}

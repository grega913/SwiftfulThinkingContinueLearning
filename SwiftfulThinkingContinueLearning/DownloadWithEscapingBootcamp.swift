//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 22/07/2023.
//

import SwiftUI


/*struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}
 */

class DownloadWithEscapingViewModel: ObservableObject {
    
    
    @Published var posts: [PostModel] = []
    
    init () {
        print("init")
        getPosts()
    }
    
    func getPosts() {
        print("getPosts")
        
        //single post example
        //guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        //array example
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return }
        
        
        downloadData(fromURL: url) {(returnedData) in
            if let data = returnedData {
                //single
                //guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
                
                //array
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    //single
                    //self?.posts.append(newPost)
                    
                    //array
                    self?.posts = newPosts
                }
            } else {
                print("No data returned.")
            }
            
        }
        
    }
        
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        print("fun downloadData")
        URLSession.shared.dataTask(with: url) { (  data, response, error) in
            
            guard //combined guard . . with multiple checks
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        .resume()
    }
    }


struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm: DownloadWithEscapingViewModel = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                Text(post.title)
                    .font(.headline)
                Text(post.body)
                    .font(.body)
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}

//
//  DownloadWithCombine.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 24/07/2023.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init () {
        print("fun init")
        getPosts()
    }
    
    func getPosts() {
        print("fun fetPosts")
        
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //Combine duscussion
        /*
         // 1. sign up for monthly subscription for package to be delivered
         // 2. the company would make the package behind the scene
         // 3. receive the package at your front door
         // 4. make sure the box isn't damaged
         // 5. open and make sure the item is correct
         // 6. use the item!!!
         // 7. cancellable at any time!!
         
         // 1. create the publisher
         // 2. subscribe the publisher on background thread - by default
         // 3. receive on the main thread
         // 4. tryMap - check if data is ok
         // 5. decode (decode data into PostModels)
         // 6. sink (put the item into our app)
         // 7. store (cancel subsription if needed)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
        //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            /*
            .tryMap{ (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }*/
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            /*.sink { (completion) in
                print("COMPLETION: \(completion)")
                switch(completion) {
                case .finished:
                    print("finished!")
                case .failure(let error):
                    print("There was an error. \(error)")
                }
                
            }*/
            .sink(receiveValue: {[weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
        
        
        
        
    }
    
    

    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        print("func handleOutput")
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}

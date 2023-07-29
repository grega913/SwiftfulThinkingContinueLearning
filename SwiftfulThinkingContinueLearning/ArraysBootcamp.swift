//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 20/07/2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
    
    
    
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    
    
    init () {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //sort
        //filter
        //map
        
        //sort
        /*let sortedArray = dataArray.sorted { (user1, user2) -> Bool in
            return user1.points > user2.points
        }
        
        filteredArray = sortedArray
         */
        
        //short version of sorted
        /*
        filteredArray = dataArray.sorted(by: { $0.points > $1.points})
         */
        
        //filter
        /*
        filteredArray = dataArray.filter({ user -> Bool in
            //user.points > 50
            user.isVerified
        })
        
        filteredArray = dataArray.filter({
            $0.isVerified
        })
        */
        
        //map
        /*
        mappedArray = dataArray.map ({ (user) -> String in
            return user.name
        })
        */
        mappedArray = dataArray.map({ $0.name})
        
        
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Diane", points: 15, isVerified: false)
        let user3 = UserModel(name: "Pero", points: 25, isVerified: true)
        let user4 = UserModel(name: "Snesa", points: 35, isVerified: false)
        let user5 = UserModel(name: "Boris", points: 54, isVerified: true)
        let user6 = UserModel(name: "Kampl", points: 55, isVerified: true)
        let user7 = UserModel(name: "Dejci", points: 56, isVerified: true)
        let user8 = UserModel(name: "Jajc", points: 55, isVerified: true)
        let user9 = UserModel(name: "Dick", points: 547, isVerified: false)
        let user10 = UserModel(name: "HHHH", points: 5555, isVerified: true)
        
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])

    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
//                ForEach(vm.filteredArray) { user in
//                    VStack (alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if(user.isVerified) {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//
//                }
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                    
                }
                
                
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}

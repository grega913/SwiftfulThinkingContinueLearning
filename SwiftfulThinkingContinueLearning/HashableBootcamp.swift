//
//  HashableBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 20/07/2023.
//

import SwiftUI


/*
 We could use Identifiable, but sometimeswe don't want ID to be visible, so we can use Hashable
 */

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    
    //a string conforms to a protocol hashable . . creates a unique ID
//    let data: [String] = [
//    "one", "two", "three", "four", "five"
//    ]
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE"),
    ]
    
    
    var body: some View {
        ScrollView {
            VStack (spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.title + " " + item.hashValue.description)
                        .font(.headline)
                }
                
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}

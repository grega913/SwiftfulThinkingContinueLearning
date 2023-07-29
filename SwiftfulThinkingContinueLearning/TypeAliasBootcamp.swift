//
//  TypeAliasBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 21/07/2023.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}



typealias TVModel = MovieModel

struct TypeAliasBootcamp: View {
    
    @State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    
    @State var tvitem: TVModel = TVModel(title: "TvTitle", director: "Emily", count: 5)
    
    var body: some View {
        VStack {
            Text(tvitem.title)
            Text(tvitem.director)
            Text("\(tvitem.count)")
        }
    }
}

struct TypeAliasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypeAliasBootcamp()
    }
}

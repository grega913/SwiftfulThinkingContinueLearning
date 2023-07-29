//
//  BackgroundThreadBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 21/07/2023.
//

import SwiftUI


class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData () {
        
        //Using backgreound thread
        // When we call async, next piece of code is happening on a different thread, so if we want to reference "parent" we need to use self
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            
            print("Check1: \(Thread.isMainThread)")
            print("Check1: \(Thread.current)")
            
            
            //before updating UI, we should go back to the main thread
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check2: \(Thread.isMainThread)")
                print("Check2: \(Thread.current)")

            }
            
            
        }
        

    }
    
   private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
    
}


struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}

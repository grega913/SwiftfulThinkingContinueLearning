//
//  WeakSelfBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 21/07/2023.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init () {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination:WeakSelfSecondScreen())
                .navigationTitle("Screen1")
        }
        .overlay(
        Text("\(count ?? 0)")
            .font(.largeTitle)
            .padding()
                .background(Color.green.cornerRadius(10))
                , alignment: .topTrailing )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}



class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("initialize now")
        
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    
    func getData() {
        data = "NEW DATA!!!"
            
        //creating a stronmg reference to class, meaning that class cannot be deinitialized
        // until clousure completes
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
//            self.data = "NEW DATA!!!"
//        }
        
        //alternative . . using weak self
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!"
        }



    }
}



struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}

//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 21/07/2023.
//

import SwiftUI

class EscapingVieModel : ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        /*
         let newData = downloadData2()
         text = newData
         */
        
        /*
         downloadData2 {(returnedData) in
         text = returnedData
         }
         */
        
        /*
         downloadData3 { [weak self] (returnedData) in
         self?.text = returnedData
         
         }
         */
        
        /*
        downloadData4 { [weak self] (returnedResult) in
            self?.text = returnedResult.data
            
        }
         */
        downloadData5 { [weak self] (returnedResult) in
            self?.text = returnedResult.data
            
        }
        
        
    }
    
    
    /*
     When we have return: synchronous line by line
     */
    func downloadData() -> String {
        return "New Data!"
    }
    
    /*
     Async . . not resolvnig immediately
     */
    
    /*
     Closure is adding a function as a parameter to an original function
     
     
     func downloadData2() -> String {
     
     DispatchQueue.main.asyncAfter(deadline: .now + 2) {
     return "New Data2!"
     }
     */
    
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New Data From Completion Handler")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New Data from download3")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let result = DownloadResult(data: "New data from d4")
            
            completionHandler(result)
        }
        
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let result = DownloadResult(data: "New data from d5")
            
            completionHandler(result)
        }
        
    }
}

    
struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()
    
struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingVieModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}

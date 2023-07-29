//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 19/07/2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}


// 1 - use binding
// 2 - multiple .sheets
// 3 - use $item


// we can only use one sheet modifier per view hierarchy

struct MultipleSheetsBootcamp: View {
    
    
    
    //@State var selectedIndex: Int = 0
    //@State var showSheet2: Bool = false
    
    
    var body: some View {
        
        //MultipleSheets1()
        
        MultipleSheets2()
        
        MultipleSheets3()
        
        // avoid any logic in sheet closure !!
        //
//        .sheet(isPresented: $showSheet) {
//            if selectedIndex == 1 {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))
//            } else if selectedIndex == 2 {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            } else {
//                NextScreen(selectedModel: RandomModel(title: "STARTING TITLE"))
//            }
//
//        }
    }
}
                                            
struct MultipleSheets1: View {
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing:20) {
            Button("Button1") {
                
                selectedModel = RandomModel(title: "ONE")
                showSheet.toggle()
            }
            
            Button("Button2") {
                
                selectedModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
            
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: $selectedModel)
        }
    }
}

//using multiple sheets
struct MultipleSheets2: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    
    var body: some View {
        
        VStack(spacing:20) {
            Button("Button1") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet, content: {
                NextScreen2(selectedModel: RandomModel(title: "1"))
            })
                        
            Button("Button2") {
                showSheet2.toggle()
            }
            .sheet(isPresented: $showSheet2, content: {
                NextScreen2(selectedModel: RandomModel(title: "2"))
            })
            
        }
    }
}


//items
struct MultipleSheets3: View {
    
    @State var selectedModel: RandomModel? = nil
   
    
    var body: some View {
        
        ScrollView {
            VStack(spacing:20) {
                
                ForEach(0..<25) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen2(selectedModel: model )
                
            }

        }
        
    }
}
                                            
struct NextScreen: View {
    //let selectedModel: RandomModel
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct NextScreen2: View {
    let selectedModel: RandomModel
    
    //@Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
            .background(.green)
    }
}
                                            
                                            

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
                                            
                                            
                                            
                                            


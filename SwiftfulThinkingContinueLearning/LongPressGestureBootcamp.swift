//
//  LongPressGestureBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 17/07/2023.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                           .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height:55)
                .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray)
            
            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture (minimumDuration: 1.0, maximumDistance: 50) { isPressing in
                           
                        if isPressing {
                            withAnimation(.easeOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if (!isSuccess) {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                    
                                }
                            }
                            }
                        } perform : {
                            withAnimation(.easeInOut) {
                                isSuccess = true                            }
                        }
                
                
                
                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
    
              
            
        }
        
        
        
//        Text(isComplete ? "COMPLETED" : "NOT COMPLETE")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? .green : .red)
//            .cornerRadius(10)
//            /*
//            .onTapGesture {
//                isComplete.toggle()
//            }
//             */
//            .onLongPressGesture(
//                minimumDuration: 5.0,
//                maximumDistance: 50) {
//                    isComplete.toggle()
//                }
                        
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}

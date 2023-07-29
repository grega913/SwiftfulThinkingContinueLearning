//
//  DragGestureBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 18/07/2023.
//

import SwiftUI

struct DragGestureBootcamp: View {
    var body: some View {
        
        @State var offset: CGSize = .zero
        
        RoundedRectangle(cornerRadius: 20)
            .fill(.red)
            .frame(width: 100, height: 100)
            
            .offset(offset)
            .gesture(
                DragGesture()
                
                    .onChanged { value in
                        withAnimation(.spring()) {
                            offset = value.translation
                        }
                    }
                
                    .onEnded { value in
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
            
            
            )
        
        
    }
}




struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}

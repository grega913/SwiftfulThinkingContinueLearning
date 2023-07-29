//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 19/07/2023.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 0
    
    
    var body: some View {
        ZStack {
            starsView
                .overlay(

                    overlayView.mask(starsView)

                    //.mask(starsView)
                )
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                        
                    }
            }
            
        }

    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}

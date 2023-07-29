//
//  SoundsBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 20/07/2023.
//

import SwiftUI
import AVKit



class SoundManager {
    
    //singleton
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        
       //guard let url = URL(string:"") else { return }
        guard let url = Bundle.main.url(
            forResource: sound.rawValue, withExtension: ".mp3") else {return}
        
        
        do {
            player = try AVAudioPlayer (contentsOf: url)
            player?.play()
            
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
        
        
    }
    
    
}

struct SoundsBootcamp: View {
    

    
    var body: some View {
        VStack (spacing: 40 ) {
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}

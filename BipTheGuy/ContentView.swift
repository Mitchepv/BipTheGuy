//
//  ContentView.swift
//  BipTheGuy
//
//  Created by Nia Mitchell on 2/4/26.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    var body: some View {
        VStack {
            Image("clown")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    playSound(soundName: "punchSound")
                }
            
            Spacer(
                
            )
            Button {
                
            } label: {
                Label( "Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }

            
        }
        .padding()
    }
    
    func playSound(soundName: String  ){
        if audioPlayer != nil && audioPlayer.isPlaying {
                audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else { print ("😡 Could not read file named \(soundName) ")
            return
        }
        do { audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play() }
        catch {
            print ("ERROR! 😡 \(error.localizedDescription) ")
        }
    }
}

#Preview {
    ContentView()
}

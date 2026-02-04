//
//  ContentView.swift
//  BipTheGuy
//
//  Created by Nia Mitchell on 2/4/26.
//

import SwiftUI
import AVFAudio
import PhotosUI

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
//    @State private var scale = 1.0
    @State private var isFullSize = true
    @State private var selectPhoto: PhotosPickerItem?
    @State private var bipTmage = Image("clown")
    
    var body: some View {
        VStack {
           bipTmage
                .resizable()
                .scaledToFit()
                .scaleEffect(isFullSize ? 1.0 : 0.9)
                .onTapGesture {
                    playSound(soundName: "punchSound")
                    isFullSize = false
                    withAnimation (.spring(response: 1.0 , dampingFraction: 0.05) ){
                        isFullSize = true
                    }
                }
//                .animation(.spring(response: 1.0 , dampingFraction: 0.05) , value: scale)
            
            Spacer(
                
            )
            
            PhotosPicker(selection: $selectPhoto, matching: .images , preferredItemEncoding: .automatic) {
                Label( "Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }
            .onChange(of: selectPhoto) {
                Task {
                    guard let selectedImage = try?  await
                            selectPhoto?.loadTransferable(type: Image.self) else {
                        print ("😡ERROR: Could not get image from loadTranferrable ")
                        return
                    }
                    bipTmage = selectedImage
                }
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

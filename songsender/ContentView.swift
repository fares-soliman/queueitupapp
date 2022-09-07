//
//  ContentView.swift
//  songsender
//
//  Created by Fares Soliman on 2022-07-11.
//

import SwiftUI
import StoreKit
import CoreBluetooth
import MediaPlayer

struct ContentView: View {
    @State private var selection = 0
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @State private var currentSong = Song(id: "", name: "", artistName: "", artworkURL: "")
    
    var body: some View {
            SearchView(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
                .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
//        }
        .accentColor(.pink)
        .onAppear() {
            SKCloudServiceController.requestAuthorization { status in
                if status == .authorized {
                    PeripheralViewController.sharedInstance.start()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

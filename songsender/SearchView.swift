//
//  SearchView.swift
//  songsender
//
//  Created by Fares Soliman on 2022-07-11.
//

import SwiftUI
import StoreKit
import MediaPlayer
import UIKit
import SDWebImageSwiftUI
import StatusAlert

struct SearchView: View {
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var currentSong: Song
        
    @State private var searchText = ""
    @State private var searchResults = [Song]()
    @State private var statusAlert = StatusAlert()
    
    var body: some View {
        VStack {
            TextField("Search Songs", text: $searchText, onCommit: {
                UIApplication.shared.resignFirstResponder()
                if self.searchText.isEmpty {
                    self.searchResults = []
                } else {
                    SKCloudServiceController.requestAuthorization { (status) in
                        if status == .authorized {
                            // 4
                            self.searchResults = AppleMusicAPI().searchAppleMusic(self.searchText)
                        }
                    }
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
            .accentColor(.pink)
            
            List {
                ForEach(searchResults, id:\.id) { song in
                    HStack {
                        WebImage(url: URL(string: song.artworkURL.replacingOccurrences(of: "{w}", with: "80").replacingOccurrences(of: "{h}", with: "80")))     .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                            .shadow(radius: 2)
             
                        VStack(alignment: .leading) {
                            Text(song.name)
                                .font(.headline)
                            Text(song.artistName)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.pink)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.currentSong = song
                        PeripheralViewController.sharedInstance.sendMessage(songID: song.id)
                        statusAlert.showInKeyWindow()
                    }
                }
            }
            .accentColor(.pink)
        }
        .onAppear(){
            statusAlert.image = UIImage(systemName: "arrow.up.circle.fill")
            statusAlert.title = "Song sent"
            statusAlert.canBePickedOrDismissed = true
        }
    }
}


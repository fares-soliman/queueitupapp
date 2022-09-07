//
//  PlayerView.swift
//  songsender
//
//  Created by Fares Soliman on 2022-07-11.
//

import SwiftUI
import MediaPlayer
import SDWebImageSwiftUI

struct PlayerView: View {
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var currentSong: Song

    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing: 24){
                
                WebImage(url: URL(string: self.currentSong.artworkURL.replacingOccurrences(of: "{w}", with: "\(Int(geometry.size.width - 24) * 2)").replacingOccurrences(of: "{h}", with: "\(Int(geometry.size.width - 24) * 2)")))                    .resizable()
                    .frame(width: geometry.size.width - 24, height: geometry.size.width - 24, alignment: .center)
                    .cornerRadius(20)
                    .shadow(radius: 10)
            
                VStack(spacing: 8) {
                    Text(currentSong.name)
                        .font(Font.system(.title).bold())
                    Text(currentSong.artistName)
                        .font(.system(.headline))
                }
                
                HStack{
                    Button(action: {
                        print("Rewind")
                    }) {
                        ZStack{
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: 10)
                            Image(systemName: "backward.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                    
                    Button(action: {
                        print("Pause")
                    }) {
                        ZStack{
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                    
                    Button(action: {
                        print("Fast-Forward")
                    }) {
                        ZStack{
                            Circle()
                                .frame(width: 80, height: 80)
                                .accentColor(.pink)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            Image(systemName: "forward.fill")
                                .foregroundColor(.white)
                                .font(.system(.title))
                        }
                    }
                }
                

            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView()
//    }
//}

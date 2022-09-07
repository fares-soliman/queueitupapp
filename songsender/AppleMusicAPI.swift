//
//  AppleMusicAPI.swift
//  songsender
//
//  Created by Fares Soliman on 2022-07-11.
//

import StoreKit
 
class AppleMusicAPI {
    let developerToken = "Your token here"
    
    func searchAppleMusic(_ searchTerm: String!) -> [Song] {
        let lock = DispatchSemaphore(value: 0)
        var songs = [Song]()
     
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/us/search?term=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
     
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            
            if let json = try? JSON(data: data!) {
                let result = (json["results"]["songs"]["data"]).array!
                for song in result {
                    let attributes = song["attributes"]
                    let currentSong = Song(id: attributes["playParams"]["id"].string!, name: attributes["name"].string!, artistName: attributes["artistName"].string!, artworkURL: attributes["artwork"]["url"].string!)
                    songs.append(currentSong)
                }
                lock.signal()
                } else {
                    lock.signal()
                }
     
        }.resume()
        
        lock.wait()
        return songs
    }
}


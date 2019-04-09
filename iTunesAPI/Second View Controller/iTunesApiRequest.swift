
import Foundation
import UIKit

struct MovieDictionary : Decodable {
    let results : [TopLevel]
}

struct TopLevel: Codable {
    let wrapperType, kind: String
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double
    let collectionExplicitness, trackExplicitness: String
    let discCount, discNumber, trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country, currency, primaryGenreName: String
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, trackPrice, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName
    }
}


extension SecondViewController {
    func movieJSONRequest() {
        let jsonUrlPath = "https://itunes.apple.com/search?term=\(artistName)&media=music&limit=10"
        
        guard let url = URL(string: jsonUrlPath) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieDictionary.self, from: data)
            
                for i in result.results {
                    self.movieResults.append(i)
                }
                
                DispatchQueue.main.async {
                    self.swipingCollectView.reloadData()
                }
            }
                
            catch let jsonError {
                print("Error", jsonError)
            }
            } .resume()
    }
}

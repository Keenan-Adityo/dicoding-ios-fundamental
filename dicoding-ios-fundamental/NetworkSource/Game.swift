//
//  GamesModel.swift
//  dicoding-ios-fundamental
//
//  Created by Keenan Adityo on 11/02/24.
//

import Foundation
import UIKit

var count = 0

enum DownloadState {
  case new, downloaded, failed
}

struct Game {
    let id: Int
    let name: String
    let backgroundImage: URL
    let rank: Int
    let released: String
    let rating: Double
    let ratingsCount: Int
    
    var image: UIImage?
    
    var state: DownloadState = .new
    
    init(id :Int,
         name: String,
         backgroundImage: URL,
         released: String,
         rating: Double,
         ratingsCount: Int,
         rank: Int
    ) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
        self.rank = rank
        self.released = released
        self.rating = rating
        self.ratingsCount = ratingsCount
    }
}

struct GameResponses: Codable {
    let count: Int
    let games: [GameResponse]

    enum CodingKeys: String, CodingKey {
        case count
        case games = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.games = try container.decode([GameResponse].self, forKey: .games)
    }
    
}

struct GameResponse: Codable {
    let id: Int
    let name, released: String
    let backgroundImage: URL
    let rating: Double
    let ratingsCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
        case ratingsCount = "ratings_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.released = try container.decode(String.self, forKey: .released)
        self.backgroundImage = try container.decode(URL.self, forKey: .backgroundImage)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
    }
}

//let dummyGamesData = [
//    Game(id: 1, name: "dummy", backgroundImage: UIImage(named: "keenan")!, rank: 1, releaseDate: "2"),
//    Game(id: 2, name: "ayam", backgroundImage: UIImage(named: "keenan")!, rank: 2, releaseDate: "3"),
//    Game(id: 2, name: "test", backgroundImage: UIImage(named: "keenan")!, rank: 2, releaseDate: "4"),
//]

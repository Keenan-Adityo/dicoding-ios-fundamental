//
//  NetworkService.swift
//  dicoding-ios-fundamental
//
//  Created by Keenan Adityo on 15/02/24.
//

import Foundation

class NetworkService {
    let apiKey = "2ef9f2ca686045cdb422685b8e9e656b"
    
    func getGames() async throws -> [Game] {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        components.queryItems = [
        URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        print(request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
          fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameResponses.self, from: data)
        count = 0
        return gameMapper(input: result.games)
    }
}

extension NetworkService {
  fileprivate func gameMapper(
    input gameResponse: [GameResponse]
  ) -> [Game] {
    return gameResponse.map { result in
        count += 1
        return Game(id: result.id, name: result.name, backgroundImage: result.backgroundImage, released: result.released, rating: result.rating, ratingsCount: result.ratingsCount, rank: count
      )
    }
  }
}

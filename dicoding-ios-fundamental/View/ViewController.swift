//
//  ViewController.swift
//  dicoding-ios-fundamental
//
//  Created by Keenan Adityo on 11/02/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var gamesTableView: UITableView!
    
    private var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      Task {
        await getGames()
      }
    }

    func getGames() async {
      let network = NetworkService()
      do {
          print("masuk")
        games = try await network.getGames()
          print("sini")
        gamesTableView.reloadData()
      } catch {
//        fatalError("Error: connection failed.")
          print("Error fetching games: \(error)")
      }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GamesTableViewCell {
            var game = games[indexPath.row]
            cell.gameTitle.text = game.name
            cell.cellImage.image = game.image
            cell.rankLabel.text = "Rank : \(game.rank)"
            cell.releaseDateLabel.text = "Release Date : \(game.released)"
            
            if game.state == .new {
              cell.indicatorLoading.isHidden = false
              cell.indicatorLoading.startAnimating()
                print(indexPath)
                startDownload(game: game, indexPath: indexPath) { updatedGame in
                    game = updatedGame
                    self.games[indexPath.row] = game
                }
            } else {
              cell.indicatorLoading.stopAnimating()
              cell.indicatorLoading.isHidden = true
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    fileprivate func startDownload(game: Game, indexPath: IndexPath, completion: @escaping (Game) -> Void) {
        var updatedGame = game // Create a mutable copy of the game
        
        let imageDownloader = ImageDownloader()
        if game.state == .new {
            Task {
                do {
                    let image = try await imageDownloader.downloadImage(url: game.backgroundImage)
                    updatedGame.state = .downloaded
                    updatedGame.image = image
                    self.gamesTableView.reloadRows(at: [indexPath], with: .automatic)
                } catch {
                    updatedGame.state = .failed
                    updatedGame.image = nil
                }
                completion(updatedGame) // Call the completion closure with the updated game
            }
        }
    }
 
}

extension ViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
      performSegue(withIdentifier: "moveToDetail", sender: games[indexPath.row])
  }
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
      ) {
        if segue.identifier == "moveToDetail" {
          if let detaiViewController = segue.destination as? DetailViewController {
            detaiViewController.game = sender as? Game
          }
        }
      }

}

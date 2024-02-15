//
//  DetailViewController.swift
//  dicoding-ios-fundamental
//
//  Created by Keenan Adityo on 13/02/24.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var ratingCountsLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var gamesImage: UIImageView!
    var game: Game? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = game {
            ratingLabel.text = "Rating : \(result.rating)"
            releaseDateLabel.text = "Release Date : \(result.released)"
            titleLabel.text = result.name
            rankLabel.text = "Rank : \(result.rank)"
            gamesImage.image = result.image
            ratingCountsLabel.text = "Ratings Count : \(result.ratingsCount)"
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

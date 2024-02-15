//
//  GamesTableViewCell.swift
//  dicoding-ios-fundamental
//
//  Created by Keenan Adityo on 11/02/24.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet var releaseDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

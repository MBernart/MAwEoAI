//
//  MovieTableViewCell.swift
//  StarWars
//
//  Created by student on 22/10/2026.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
        
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        posterImageView.image = UIImage(named: movie.thumbnailName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

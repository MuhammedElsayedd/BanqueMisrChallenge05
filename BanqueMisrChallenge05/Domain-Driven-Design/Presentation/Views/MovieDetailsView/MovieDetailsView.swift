//
//  MovieDetailsView.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import UIKit

class MovieDetailsView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with movieDetails: MovieDetails) {
        titleLabel.text = movieDetails.title
        overviewLabel.text = movieDetails.overview
        genresLabel.text = movieDetails.genres.map { $0.name }.joined(separator: ", ")
        runtimeLabel.text = "\(movieDetails.runtime) minutes"
        
        if let posterPath = movieDetails.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let url = URL(string: urlString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.posterImageView.image = image
                        }
                    }
                }
            }
        }
    }
}

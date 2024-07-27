//
//  MovieDetailsView.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import UIKit

class MovieDetailsView: UIView {
    //MARK: Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    func loadFromNib() {
        let xibType = type(of: self)
        let bundle = Bundle(for: xibType)
        guard let contentView = bundle.loadNibNamed(String(describing: xibType), owner: self, options: nil)?.first as? UIView else { return }
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with movieDetails: MovieDetails) {
        titleLabel.text = movieDetails.title ?? "N/A"
        overviewLabel.text = movieDetails.overview ?? "N/A"
        genresLabel.text = movieDetails.genres?.compactMap { $0.name }.joined(separator: ", ") ?? "N/A"
        runtimeLabel.text = movieDetails.runtime != nil ? "\(movieDetails.runtime!) minutes" : "N/A"
        
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

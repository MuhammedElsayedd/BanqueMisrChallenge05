//
//  MovieDetailsViewController.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieId: Int!
    private var viewModel = MovieDetailsViewModel()
    private var movieDetailsView: MovieDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customView = Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)?.first as? MovieDetailsView {
            movieDetailsView = customView
            view.addSubview(movieDetailsView)
            movieDetailsView.frame = view.bounds
        }
        
        viewModel.onDetailsFetched = { [weak self] in
            DispatchQueue.main.async {
                if let details = self?.viewModel.movieDetails {
                    self?.movieDetailsView.configure(with: details)
                }
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: error)
            }
        }
        
        fetchMovieDetails()
    }
    
    private func fetchMovieDetails() {
        viewModel.fetchMovieDetails(for: movieId)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

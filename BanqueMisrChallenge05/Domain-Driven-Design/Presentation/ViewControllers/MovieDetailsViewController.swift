//
//  MovieDetailsViewController.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    var movieId: Int!
    
    private var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupBindings()
        viewModel.fetchMovieDetails()
    }
    
    private func setupViewModel() {
        let networkManager = NetworkManager.shared
        let movieDetailsRepository = MovieDetailsRepositoryImpl(networkManager: networkManager)
        viewModel = MovieDetailsViewModel(movieId: movieId, repository: movieDetailsRepository)
    }

    private func setupBindings() {
        viewModel.onMovieDetailsFetched = { [weak self] movieDetails in
            DispatchQueue.main.async {
                self?.movieDetailsView.configure(with: movieDetails)
            }
        }

        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: error)
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

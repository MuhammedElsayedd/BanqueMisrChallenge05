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
        fetchMovieDetails()
    }
    
    private func setupViewModel() {
        let networkManager = NetworkManager.shared
        let movieDetailsUseCase = MovieDetailsUseCaseImpl(networkManager: networkManager)
        viewModel = MovieDetailsViewModel(movieDetailsUseCase: movieDetailsUseCase)
    }

    private func setupBindings() {
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
    }

    private func fetchMovieDetails() {
        viewModel.fetchMovieDetails(movieId: movieId)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//
//  MovieDetailsViewModel.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import Foundation

class MovieDetailsViewModel {
    private var networkManager: NetworkManager = NetworkManager.shared
    var movieDetails: MovieDetails?
    
    var onDetailsFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchMovieDetails(for movieId: Int) {
        networkManager.fetchMovieDetails(for: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.movieDetails = movieDetails
                self?.onDetailsFetched?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}

//
//  MovieDetailsViewModel.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import Foundation

class MovieDetailsViewModel {
    private let repository: MovieDetailsRepository
    private let movieId: Int
    
    var movieDetails: MovieDetails?
    var onMovieDetailsFetched: ((MovieDetails) -> Void)?
    var onError: ((String) -> Void)?

    init(movieId: Int, repository: MovieDetailsRepository) {
        self.movieId = movieId
        self.repository = repository
    }

    func fetchMovieDetails() {
        repository.fetchMovieDetails(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.movieDetails = movieDetails
                self?.onMovieDetailsFetched?(movieDetails)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}

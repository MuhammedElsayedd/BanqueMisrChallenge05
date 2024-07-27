//
//  MovieDetailsViewModel.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import Foundation

class MovieDetailsViewModel {
    private let movieDetailsUseCase: MovieDetailsUseCase
    var movieDetails: MovieDetails?
    
    var onDetailsFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(movieDetailsUseCase: MovieDetailsUseCase) {
        self.movieDetailsUseCase = movieDetailsUseCase
    }
    
    func fetchMovieDetails(movieId: Int) {
        movieDetailsUseCase.execute(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let details):
                self?.movieDetails = details
                self?.onDetailsFetched?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}

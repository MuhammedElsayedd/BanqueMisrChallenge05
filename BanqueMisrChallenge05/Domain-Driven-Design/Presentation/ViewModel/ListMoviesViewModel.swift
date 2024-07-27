//
//  ListMoviesViewModel.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//
import Foundation

class ListMoviesViewModel {
    private let movieUseCase: MovieUseCase
    var movies: [Movie] = []
    var category: MovieCategory = .nowPlaying
    
    var onMoviesFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovies() {
        switch category {
        case .nowPlaying:
            movieUseCase.fetchNowPlayingMovies { [weak self] result in
                self?.handleResult(result)
            }
        case .popular:
            movieUseCase.fetchPopularMovies { [weak self] result in
                self?.handleResult(result)
            }
        case .upcoming:
            movieUseCase.fetchUpcomingMovies { [weak self] result in
                self?.handleResult(result)
            }
        }
    }

    private func handleResult(_ result: Result<[Movie], Error>) {
        switch result {
        case .success(let movies):
            self.movies = movies
            self.onMoviesFetched?()
        case .failure(let error):
            self.onError?(error.localizedDescription)
        }
    }
}

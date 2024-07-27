//
//  ListMoviesViewModel.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//
import Foundation

class ListMoviesViewModel {
    private let movieRepository: MovieRepository
    var movies: [Movie] = []
    var category: MovieCategory = .nowPlaying
    
    var onMoviesFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies() {
        switch category {
        case .nowPlaying:
            movieRepository.fetchNowPlayingMovies { [weak self] result in
                self?.handleResult(result)
            }
        case .popular:
            movieRepository.fetchPopularMovies { [weak self] result in
                self?.handleResult(result)
            }
        case .upcoming:
            movieRepository.fetchUpcomingMovies { [weak self] result in
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

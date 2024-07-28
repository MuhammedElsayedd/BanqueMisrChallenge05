//
//  NetworkManagerMock.swift
//  BanqueMisrChallenge05Tests
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import Foundation
@testable import BanqueMisrChallenge05

class NetworkManagerMock: NetworkManager {
    var shouldReturnError = false
    
    override init() {
        super.init()
    }
    
    override func fetchMovies(from endpoint: Endpoint, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.noData))
        } else {
            let movies = (0..<10).map { Movie(id: $0, title: "Movie \($0)", releaseDate: "2023-01-01", posterPath: "/path\($0)") }
            completion(.success(movies))
        }
    }
    
    override func fetchMovieDetails(for movieId: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.noData))
        } else {
            let movieDetails = MovieDetails(id: movieId, title: "Movie \(movieId)", overview: "Overview \(movieId)", genres: [], runtime: 120, posterPath: "/path\(movieId)")
            completion(.success(movieDetails))
        }
    }
}

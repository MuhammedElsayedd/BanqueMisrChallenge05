//
//  MovieUseCaseMock.swift
//  BanqueMisrChallenge05Tests
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import Foundation
@testable import BanqueMisrChallenge05

class MovieUseCaseMock: MovieUseCase {
    var shouldReturnError = false

    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.noData))
        } else {
            let movies = (0..<10).map { Movie(id: $0, title: "Movie \($0)", releaseDate: "2023-01-01", posterPath: "/path\($0)") }
            completion(.success(movies))
        }
    }

    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.noData))
        } else {
            let movies = (0..<10).map { Movie(id: $0, title: "Movie \($0)", releaseDate: "2023-01-01", posterPath: "/path\($0)") }
            completion(.success(movies))
        }
    }

    func fetchUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.noData))
        } else {
            let movies = (0..<10).map { Movie(id: $0, title: "Movie \($0)", releaseDate: "2023-01-01", posterPath: "/path\($0)") }
            completion(.success(movies))
        }
    }
}

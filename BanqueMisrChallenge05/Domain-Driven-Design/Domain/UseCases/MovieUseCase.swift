//
//  MovieUseCase.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import Foundation

protocol MovieUseCase {
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieUseCaseImpl: MovieUseCase {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkManager.fetchMovies(from: .nowPlaying) { result in
            completion(result.mapError { $0 as Error })
        }
    }

    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkManager.fetchMovies(from: .popular) { result in
            completion(result.mapError { $0 as Error })
        }
    }

    func fetchUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkManager.fetchMovies(from: .upcoming) { result in
            completion(result.mapError { $0 as Error })
        }
    }
}

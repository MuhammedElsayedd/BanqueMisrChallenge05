//
//  MovieDetailsRepository.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import Foundation

protocol MovieDetailsRepository {
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void)
}

class MovieDetailsRepositoryImpl: MovieDetailsRepository {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        networkManager.fetchMovieDetails(for: movieId, completion: completion)
    }
}

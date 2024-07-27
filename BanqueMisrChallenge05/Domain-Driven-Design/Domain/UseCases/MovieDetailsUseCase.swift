//
//  MovieDetailsUseCase.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import Foundation

protocol MovieDetailsUseCase {
    func execute(movieId: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void)
}
class MovieDetailsUseCaseImpl: MovieDetailsUseCase {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func execute(movieId: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        networkManager.fetchMovieDetails(for: movieId, completion: completion)
    }
}

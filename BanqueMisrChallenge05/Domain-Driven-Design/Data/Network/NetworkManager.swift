//
//  NetworkManager.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 25/07/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    public init() {}
    
    func fetchMovies(from endpoint: Endpoint, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlWithKey = url.appending("api_key", value: APIConfiguration.apiKey)
        
        URLSession.shared.dataTask(with: urlWithKey) { data, response, error in
            if let _ = error {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchMovieDetails(for movieId: Int, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        let urlString = "\(APIConfiguration.baseURL)movie/\(movieId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlWithKey = url.appending("api_key", value: APIConfiguration.apiKey)
        
        URLSession.shared.dataTask(with: urlWithKey) { data, response, error in
            if let _ = error {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

//
//  Endpoint.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 25/07/2024.
//

import Foundation

enum Endpoint: String {
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case upcoming = "movie/upcoming"
    case movieDetails = "movie/"
    
    var url: URL? {
        return URL(string: APIConfiguration.baseURL + self.rawValue)
    }
}

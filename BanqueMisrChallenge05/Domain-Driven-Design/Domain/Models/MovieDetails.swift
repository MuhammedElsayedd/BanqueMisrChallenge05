//
//  MovieDetails.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import Foundation

struct MovieDetails: Decodable {
    let id: Int
    let title: String
    let overview: String
    let genres: [Genre]
    let runtime: Int
    let posterPath: String?
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genres
        case runtime
        case posterPath = "poster_path"
    }
}

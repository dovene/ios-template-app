//
//  Movie.swift
//  TemplateApp
//
//  Created by Dov on 23/06/2019.
//  Copyright © 2019 Dov. All rights reserved.
//

import Foundation
struct Movie {
    var title : String?
    var overview : String?
    var posterPath : String?
    var releaseDate : String?
    var popularity : Double?
    
    init() {
        title = ""
        overview = ""
        posterPath = ""
        releaseDate = ""
        popularity = 0.0
    }
}
struct MoviesResponse {
var page : Int
var results : [Movie]
}

extension MoviesResponse: Decodable, Encodable {
    enum MoviesResponseCodingKeys: String, CodingKey {
        case page
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MoviesResponseCodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(results, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MoviesResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        results = try container.decode([Movie].self, forKey: .results)
     }
}

extension Movie: Decodable, Encodable {
    enum MovieCodingKeys: String, CodingKey {
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieCodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(releaseDate, forKey: .releaseDate)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        do {
            title = try container.decode(String.self, forKey: .title)
        } catch  {
            
        }
        do {
            
            releaseDate = try container.decode(String.self, forKey: .releaseDate)
        } catch  {
            
        }
        do {
            posterPath = try container.decode(String.self, forKey: .posterPath)
        } catch  {
            
        }
        do {
            overview = try container.decode(String.self, forKey: .overview)
        } catch  {
        }
        popularity = try container.decode(Double.self, forKey: .popularity)
    }

    func getImageUrl()->String {
        return "https://image.tmdb.org/t/p/w500\(self.posterPath ?? "")"
    }
}

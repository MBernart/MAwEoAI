//
//  AllClasses.swift
//  StarWars
//
//  Created by student on 22/10/2026.
//

import Foundation

class CastMember {
    let name: String
    let character: String
    
    init(name: String, character: String) {
        self.name = name
        self.character = character
    }
    
    convenience init(castEntry: String) {
        let components = castEntry.components(separatedBy: ";")
        
        let actorName = components.first ?? castEntry
        let characterName = components.count > 1 ? components[1] : ""
        
        self.init(name: actorName, character: characterName)
    }
}

class Movie {
    let title: String
    let year: Int
    let director: String
    let runtime: String
    let posterName: String
    let cast: [CastMember]
    
    init(title: String, dictionary: [String: Any]) {
        self.title = title
        if let year = dictionary["Year"] as? Int {
            self.year = year
        } else if let year = dictionary["Year"] as? String, let value = Int(year) {
            self.year = value
        } else {
            self.year = 0
        }
        self.director = dictionary["Director"] as? String ?? ""
        self.runtime = dictionary["Runtime"] as? String ?? ""
        self.posterName = dictionary["Poster"] as? String ?? ""
        
        let castEntries = dictionary["Cast"] as? [String] ?? []
        self.cast = castEntries.map { CastMember(castEntry: $0) }
    }
    
    var thumbnailName: String {
        return "t" + posterName
    }
}

class MovieCategory {
    let name: String
    var movies: [Movie]
    
    init(name: String, movies: [Movie]) {
        self.name = name
        self.movies = movies
    }
}

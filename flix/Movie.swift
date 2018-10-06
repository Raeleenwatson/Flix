//
//  Movie.swift
//  flix
//
//  Created by Raeleen Watson on 10/6/18.
//  Copyright © 2018 Raeleen Watson. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var overview: String
    var posterURL: URL?
    var backdropURL: URL?
    //var baseURLString: String
    var releaseDate: String
    
    init(dictionary: [String: Any]) {
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No Release"
        let backdropPathString = dictionary["backdrop_path"] as! String
        let posterPathString = dictionary["poster_path"] as! String
        
        backdropURL = URL(string: baseURLString + backdropPathString)
        posterURL = URL(string: baseURLString + posterPathString)!
        
    }
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
}

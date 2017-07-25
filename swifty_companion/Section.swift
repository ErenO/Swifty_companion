//
//  Section.swift
//  swifty_companion
//
//  Created by Eren Ozdek on 04/07/2017.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import Foundation

struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}

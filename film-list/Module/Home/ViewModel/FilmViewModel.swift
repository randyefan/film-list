//
//  FilmViewModel.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 20/04/21.
//

import Foundation

struct FilmViewModel {
    
    private let film: Film
    
    var releaseDate: Int {
        return film.releaseYear
    }
    
    var description: String {
        return film.description
    }
    
    var title: String {
        return film.title
    }
    
    var director: String {
        film.director
    }
    
    init(film: Film) {
        self.film = film
    }
}

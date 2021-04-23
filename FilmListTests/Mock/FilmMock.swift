//
//  FilmMock.swift
//  FilmListTests
//
//  Created by Randy Efan Jayaputra on 23/04/21.
//

import SwiftyJSON
@testable import film_list

class FilmMock: Film {
    override init(json: JSON = "") {
        let dict: [String: Any] = [
            "title": "Indonesia Merdeka",
            "description": "Sebuah film seru",
            "release_date": "2011",
            "director": "Randy Efan"
        ]
        super.init(json: JSON(dict))
    }
}

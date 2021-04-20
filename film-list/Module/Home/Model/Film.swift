//
//  Film.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 20/04/21.
//

import Foundation
import SwiftyJSON

struct Film {
    let title: String
    let description: String
    let releaseYear: Int
    let director: String
    
    init(json: JSON) {
        title = json["title"].stringValue
        description = json["description"].stringValue
        releaseYear = json["release_date"].intValue
        director = json["director"].stringValue
    }
}

//
//  Film.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 20/04/21.
//

import Foundation
import SwiftyJSON

class Film: NSObject {
    let title: String
    let descriptionLabel: String
    let releaseYear: Int
    let director: String
    
    init(json: JSON) {
        title = json["title"].stringValue
        descriptionLabel = json["description"].stringValue
        releaseYear = json["release_date"].intValue
        director = json["director"].stringValue
    }
}

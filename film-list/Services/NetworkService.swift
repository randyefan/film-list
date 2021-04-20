//
//  NetworkManager.swift
//  film-list
//
//  Created by Randy Efan Jayaputra on 17/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIError: String {
    case networkError
    case apiError
    case decodingError
}

enum APIs: URLRequestConvertible {
    case listFilm
    
    static let endpoint = URL(string: "https://ghibliapi.herokuapp.com")
    
    var path: String {
        switch self {
        case .listFilm:
            return "/films"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: URLEncoding {
        return URLEncoding.init(destination: .methodDependent, arrayEncoding: .noBrackets)
    }
    
    func asURLRequest() throws -> URLRequest {
        let parameters = [
            "fields" : "title,description,release_date,director"
        ]
        var request = URLRequest(url: Self.endpoint!.appendingPathComponent(path))
        
        switch self {
        case .listFilm:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
}

struct NetworkService {
    let jsonDecoder = JSONDecoder()
    
    func getFilm(completion: @escaping(JSON?, APIError?) -> ()) {
        Alamofire.request(APIs.listFilm).validate().responseJSON { (json) in
            switch json.result {
            case .failure:
                completion(nil, .apiError)
            case .success(let jsonData):
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys) {
                    do {
                        let data = try JSON(data: jsonData)
                        completion(data, nil)
                    } catch {
                        completion(nil, .decodingError)
                    }
                } else {
                    completion(nil, .networkError)
                }
            }
        }
    }
}

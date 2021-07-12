//
//  JSON.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import Foundation

enum Json<T> {
    case success(T)
    case failure(AppError)
}

//Create Envelope type as a shortcut
typealias Envelope<T: Decodable> = Json<T>

// MARK: AppError
enum AppError: Error {
    case urlError
    case fileError
    case fileDataError
    case jsonSerializationFailed
    case jsonParsingFailed
}

// MARK: JsonService
// will help to parse data from file
class JsonService {
    
    // this call will parse the data from given input file of json type
    static func fetch<T: Codable>(from file: String, completion: @escaping (Envelope<T>) -> ())  {
        guard let jsonFile = Bundle.main.path(forResource: file, ofType: "json") else {
            completion(.failure(.fileError))
            return
        }
        do {
            guard let jsonData = try? String(contentsOfFile: jsonFile).data(using: .utf8) else {
                completion(.failure(.fileDataError))
                return
            }
            guard let value = try? JSONDecoder().decode(T.self, from: jsonData) else {
                completion(.failure(.jsonParsingFailed))
                return
            }
            completion(.success(value))
        }
    }
    
}

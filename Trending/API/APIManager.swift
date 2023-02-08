//
//  APIManager.swift
//  Trending
//
//  Created by Natia's Mac on 08.02.23.
//

import Foundation

final class APIManager {
    
    static var shared = APIManager()
    private init() {}
    
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type) async throws -> T {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else { throw ApiError.httpError }
        do {
           return try JSONDecoder().decode(decodingType.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw ApiError.decodingError
        }
    }
}

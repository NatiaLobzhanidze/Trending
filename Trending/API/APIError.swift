//
//  APIErrors.swift
//  Trending
//
//  Created by Natia's Mac on 08.02.23.
//

import Foundation
enum ApiError: Error {
    case invalidUrl
    case httpError
    case decodingError
}

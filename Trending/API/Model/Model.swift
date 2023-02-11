//
//  Model.swift
//  Trending
//
//  Created by Natia's Mac on 08.02.23.
//

import Foundation

struct MainResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Item: Codable {
    let fullName: String
    let githubAddress: String
    let owner: Owner
    let description: String
    let language: String?
    let stars: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case githubAddress = "html_url"
        case stars = "stargazers_count"
        case owner, description, language
    }
}

struct Owner: Codable {
    let image: String
    enum CodingKeys: String, CodingKey {
        case image = "avatar_url"
    }
}

struct DetailsData {
    let image: String
    let name: String
    let description: String
    let stars: Int
    let language: String
}

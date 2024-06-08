// Movie.swift
import Foundation

public struct MovieResponse: Codable {
    public let results: [Movie]
}

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

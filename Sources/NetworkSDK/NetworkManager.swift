// NetworkManager.swift
import Foundation
import Combine

public class NetworkManager {
    public static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "909594533c98883408adef5d56143539"
    private let language = "en-US"
    
    private init() {}
    
    @available(iOS 13.0, *)
    public func fetchPopularMovies(page: Int = 1) -> AnyPublisher<[Movie], Error> {
        //Testing
        var urlComponents = URLComponents(string: "\(baseURL)/movie/popular")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

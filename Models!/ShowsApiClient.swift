//
//  ShowsApiClient.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/13/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation

struct ShowsApiClient {
    
    static func getShows(for searchQuery: String,completion: @escaping (Result<[Show],AppError>) -> ()) {
        
        let customizedEndpoint = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        guard let url = URL(string: customizedEndpoint) else {
            completion(.failure(.badURL(customizedEndpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let showData):
                
                do {
                    let searchResults = try JSONDecoder().decode([ShowData].self, from: showData)
                    let shows = searchResults.map { $0.show }
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}

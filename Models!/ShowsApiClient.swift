//
//  ShowsApiClient.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/13/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation

struct ShowsApiClient {
    
    static func getShows(completion: @escaping (Result<[Show],AppError>) -> ()) {
    
        
        let showEndpointURL = "http://api.tvmaze.com/search/shows?q=girls"
        
        guard let url = URL(string: showEndpointURL) else {
            completion(.failure(.badURL(showEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let showData):
                
                do {
                    let searchResults = try JSONDecoder().decode([Show].self, from: showData)
                    let shows = searchResults
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}

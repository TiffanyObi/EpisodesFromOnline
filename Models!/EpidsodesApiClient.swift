//
//  EpidsodesApiClient.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/16/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation

struct EpisodeListAPIClient {
    static func fetchEpisodes(for showID:Int,
                              completion:@escaping (Result<[Episodes],AppError>) -> ()) {
        let showID = showID
        let episodeEndpoint = "https://api.tvmaze.com/shows/\(showID)/episodes"
        
        guard let url = URL(string: episodeEndpoint) else {
            completion(.failure(.badURL(episodeEndpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                
                do {
                    let episodes = try JSONDecoder().decode([Episodes].self, from: data)
                    completion(.success(episodes))
                    
                }catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
    }
}

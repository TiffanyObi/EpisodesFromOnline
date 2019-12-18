//
//  Episodes.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/16/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation
//struct AllEpisodes {
//    let result: [Episodes]
//}
struct Episodes: Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let image: Sizes?
    let summary: String?
    
}

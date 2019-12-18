//
//  Shows!.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/13/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import Foundation

struct ShowData : Decodable {
   let show: Show
}

struct Show: Decodable {
    
    let url: String
    let name: String
    let id: Int
   let type: String
   let language: String
   let genres: [String]
    let status: String
   // let premiered: String
   // let officialSite: String
    let rating: Average?
    let image: Sizes?
    let summary: String?
}

struct Average: Decodable {
    let average: Double?
}

struct Sizes: Decodable {
    let medium: String?
    let original: String?
}

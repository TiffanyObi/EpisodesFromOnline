//
//  EpisodeCell.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/16/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    func configureCell(for episode: Episodes) {
        episodeNameLabel.text = episode.name
        let image = episode.image?.medium ?? ""
        episodeImageView.getImage(with: image) { [weak self] (result) in
           switch result {
           case .failure:
               DispatchQueue.main.async {
                   self?.episodeImageView.image = UIImage(named: "movie image")
               }
           case .success(let image):
               DispatchQueue.main.async {
                   self?.episodeImageView.image = image
               }
           }
       }
   }
}

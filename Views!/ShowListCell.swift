//
//  ShowListCell.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/16/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class ShowListCell: UITableViewCell {
  
    @IBOutlet weak var showImageView: UIImageView!
    
    @IBOutlet weak var showTitleLabel: UITextView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    func configureCell(for show: Show) {
        self.backgroundColor = .green
        showTitleLabel.backgroundColor = .red
        showTitleLabel.text = show.name
       var image = ""
        ratingLabel.text = "Rating: " + "\((show.rating?.average?.description ?? "7.0"))"
        // "https" + "\(show.image?.original?.dropFirst(4) ?? "https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg")"
        guard let imageURL = show.image?.original else {
            showImageView.image = UIImage(named:"movie image")
            return
        }
        image = imageURL
        
        showImageView.getImage(with: image) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showImageView.image = UIImage(named: "movie image")   }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImageView.image = image

                }
            }
        }
    }
}

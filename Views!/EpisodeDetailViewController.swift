//
//  EpisodeDetailViewController.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/17/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeImageView: UIImageView!
    

    @IBOutlet weak var episodeSummaryLabel: UITextView!
    
    var episodeDetails: Episodes!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       updateUI()
    }
  var word = ""

    func updateUI() {
        episodeSummaryLabel.backgroundColor = .systemIndigo
       
        
        episodeSummaryLabel.text = "\(episodeDetails.summary?.dropLast(5) ?? "")"
        episodeImageView.getImage(with: episodeDetails.image?.original ?? "") {[weak self] (result) in
            switch result {
            case .failure(let appError):
            print("Error loading picture: \(appError)")
                
            case .success(let image):
                
                DispatchQueue.main.async {
                    self?.episodeImageView.image = image
                    }
                }
            }
        }
    }



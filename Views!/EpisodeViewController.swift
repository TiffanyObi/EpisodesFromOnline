//
//  EpisodeViewController.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/16/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var series: Show!
    
    var episodes = [Episodes]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchEpisode(for: series.id)
    }
    
    func searchEpisode(for seriesId: Int) {
        EpisodeListAPIClient.fetchEpisodes(for: seriesId) { (result) in
            switch result {
            case .failure(let error):
                print("error searching epispode: \(error)")
            case .success(let episodes):
                self.episodes = episodes
            }
        }
    }

}

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell else {
            fatalError("failed to dequeue to Episode Cell")
        }
        let episode = episodes[indexPath.row]
        
        episodeCell.configureCell(for: episode)
        
        return episodeCell
    }
    
    
}

extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

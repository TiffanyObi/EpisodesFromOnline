//
//  ViewController.swift
//  EpisodesFromOnline
//
//  Created by Tiffany Obi on 12/13/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show]() {
        didSet {
            DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
    
    var searchQuery = ""
    
    
    func searchShows(for searchQuery: String) {
            
        ShowsApiClient.getShows(for: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                fatalError("could not load data: \(appError)")
                
            case .success(let showsData):
                self?.shows = showsData
                dump(showsData)
                
            }
        }
        )
    }
    
    func addShow() {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       searchBar.delegate = self
        searchShows(for: "Christmas")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeVC = segue.destination as? EpisodeViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not locate view controller")
        }
        
        episodeVC.series = shows[indexPath.row]
        
    }

}
extension ShowListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ShowListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let showCell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)  as? ShowListCell else {
            fatalError("could not locate Cell")
        }
        
        let showInRow = shows[indexPath.row]
        
        
        showCell.configureCell(for: showInRow)
        
        return showCell
    }
    
    
    
}

extension ShowListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchQuery = searchBar.text ?? ""
        searchShows(for: searchQuery)
    }
    
}

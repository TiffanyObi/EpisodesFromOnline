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
    
    func searchShows() {
        ShowsApiClient.getShows() { (result) in
            switch result {
            case .failure(let appError): 
                fatalError("could not load data: \(appError)")
                
            case .success(let showsData):
                self.shows = showsData
                dump(showsData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
       // searchBar.delegate = self
       searchShows()
    }


}

extension ShowListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let showCell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)  
        
        let showInRow = shows[indexPath.row]
        
        showCell.textLabel?.text = showInRow.name
        
        
        return showCell
    }
    
    
    
}

extension ShowListViewController: UISearchBarDelegate {
    
    
}

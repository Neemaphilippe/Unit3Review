//
//  SearchViewController.swift
//  Unit3Review
//
//  Created by Pursuit on 9/18/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var podcasts = [Podcast](){
        didSet{
            searchTableView.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            searchTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    private func loadPodcastsFromSearch(){
        if let searchString = searchString {
            PodcastAPIManager.shared.getPodcasts(searchWord: searchString) {(result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let podcastsFromOnline):
                        self.podcasts = podcastsFromOnline
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
        let podcast = podcasts[indexPath.row]
        cell.collectionLabel.text = podcast.collectionName
        cell.aristLabel.text = podcast.artistName
        ImageHelper.shared.getImage(urlStr: podcast.artworkUrl60) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.podcastImage.image = imageFromOnline
                }
            }
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcastSelected = podcasts[indexPath.row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let podcastDetailVC = storyBoard.instantiateViewController(withIdentifier: "PodcastDetailViewController") as! PodcastDetailViewController
        podcastDetailVC.podcast = podcastSelected
        
        self.navigationController?.pushViewController(podcastDetailVC, animated: true)
    }
    
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.searchString = searchText
        loadPodcastsFromSearch()
    }
    
}

//
//  PodcastDetailViewController.swift
//  Unit3Review
//
//  Created by Pursuit on 9/18/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var podcastImageView: UIImageView!
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let favorite = FavoritePodcast(trackId: podcast.trackId, favoritedBy: "Neema", collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl60)
        PodcastAPIManager.shared.postPodcast(podcast: favorite) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("we posted our podcast!")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    
    var podcast: Podcast!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPodcastDetails()

        // Do any additional setup after loading the view.
    }
    

    private func setupPodcastDetails(){
        nameLabel.text = podcast.artistName
        
        ImageHelper.shared.getImage(urlStr: podcast.artworkUrl100) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    self.podcastImageView.image = imageFromOnline
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
        
        
        
    }

}

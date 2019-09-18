//
//  PodcastCell.swift
//  Unit3Review
//
//  Created by Pursuit on 9/18/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var collectionLabel: UILabel!
    
    @IBOutlet weak var podcastImage: UIImageView!
    
    @IBOutlet weak var aristLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

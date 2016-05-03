//
//  PhotoCell.swift
//  Instagram Demo
//
//  Created by Corwin Crownover on 3/15/16.
//  Copyright © 2016 Corwin Crownover. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    // OUTLETS
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!    
    
    // VIEW DID LOAD

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // FUNCTIONS
    
    
    
    
}

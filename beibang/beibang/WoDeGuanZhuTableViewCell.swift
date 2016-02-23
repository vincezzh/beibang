//
//  WoDeGuanZhuTableViewCell.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeGuanZhuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var followedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        followedLabel.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

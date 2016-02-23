//
//  WoDeShouCangTableViewCell.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeShouCangTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var likeNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorAvatarImageView.layer.cornerRadius = 0.5 * authorAvatarImageView.bounds.size.width
        authorAvatarImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

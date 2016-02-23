//
//  WoDeTouGaoTableViewCell.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-22.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class WoDeTouGaoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var postDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusImageView.layer.cornerRadius = 0.5 * statusImageView.bounds.size.width
        statusImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

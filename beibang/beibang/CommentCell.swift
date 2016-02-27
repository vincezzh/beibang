//
//  CommentCell.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-26.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeDecoration()
    }
    
    func initializeDecoration() {
        avatarImageView.layer.cornerRadius = 0.5 * avatarImageView.bounds.size.width
        avatarImageView.clipsToBounds = true
    }
    
    func initializeData(comment: Comment) {
        ImageUtil.loadImage(comment.user.avatarUrl, imageView: avatarImageView)
        nameLabel.text = comment.user.name
        postDateLabel.text = comment.postDate
        contentLabel.text = comment.content
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

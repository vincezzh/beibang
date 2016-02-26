//
//  ArticleTitleCell.swift
//  beibang
//
//  Created by Vince Zhang on 2016-02-26.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class ArticleTitleCell: UITableViewCell {
    
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var tagScrollView: UIScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeDecoration()
    }
    
    func initializeDecoration() {
        authorAvatarImageView.layer.cornerRadius = 0.5 * authorAvatarImageView.bounds.size.width
        authorAvatarImageView.clipsToBounds = true
        followButton.layer.cornerRadius = 5
    }
    
    func initializeData(touGao: TouGao) {
        ImageUtil.loadImage(touGao.author.avatarUrl, imageView: authorAvatarImageView)
        authorNameLabel.text = touGao.author.name
        followerNumberLabel.text = "💜\(touGao.author.followerNumber)"
        articleTitleLabel.text = touGao.titleText
        articleContentLabel.text = touGao.contentText.string
        
        for index in 0...touGao.tagLabelArray.count-1 {
            let tagLabel = UILabel()
            tagLabel.text = touGao.tagLabelArray[index]
            tagLabel.font = UIFont(name: tagLabel.font.fontName, size: 12)
            tagLabel.textColor = UIColor(red:154/255.0, green:127/255.0, blue:252/255.0, alpha: 1.0)
            tagLabel.frame = CGRectMake(CGFloat(index * 55), 0, 55, tagScrollView.bounds.height)
            tagScrollView.addSubview(tagLabel)
        }
        tagScrollView.contentSize = CGSizeMake(CGFloat(touGao.tagLabelArray.count * 55), tagScrollView.bounds.height)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

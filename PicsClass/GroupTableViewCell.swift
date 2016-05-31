//
//  GroupTableViewCell.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detaileLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    var group: ZQYPhotoGroup = ZQYPhotoGroup(){
    
        didSet{
            photoImage.image = group.thumbImage
            nameLabel.text = group.groupName
            detaileLabel.text = NSString(format: "%d",group.assetsCount!) as String
            
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

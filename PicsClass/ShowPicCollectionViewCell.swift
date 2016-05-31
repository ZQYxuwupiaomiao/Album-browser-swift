//
//  ShowPicCollectionViewCell.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/13.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit

protocol clickButtonInShowPicProtocol {
    func clickButtonInShowPic(tag:Int )
}

class ShowPicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var picImageView: UIImageView!

    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var selectedImage: UIImageView!

    var delegate: clickButtonInShowPicProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.picImageView.layer.masksToBounds = true
        self.picImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.selectedButton.addTarget(self, action: #selector(butonClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.selectedImage.backgroundColor = UIColor(red: 190/255.0, green: 190/255.0, blue: 190/255.0, alpha: 1)
    }

    func butonClicked(button: UIButton) {
        self.delegate?.clickButtonInShowPic(button.tag)
    }
    
    func changSubViewsStatus(asset: ZQYAssets,tag: Int) {
        self.picImageView.image = asset.thumbImage
        self.selectedButton.tag = tag;
        if asset.isSelected! {
            self.selectedImage.image = UIImage(named: "AssetsPickerChecked")
        }else{
            self.selectedImage.image = UIImage(named: "uncheck_icon")
        }
    }
    
    override func prepareForReuse() {
    }
}

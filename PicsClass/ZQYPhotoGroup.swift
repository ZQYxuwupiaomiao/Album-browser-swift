//
//  ZQYPhotoGroup.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/10.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit
import AssetsLibrary


class ZQYPhotoGroup: NSObject {

    /**
     *  组名
     */
    var groupName: String?
    
    /**
     *  缩略图
     */
    var thumbImage: UIImage?

    /**
     *  组里面的图片个数
     */
    var assetsCount: Int?

    var type: String?

    var group: ALAssetsGroup?

    
}

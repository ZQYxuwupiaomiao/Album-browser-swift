//
//  ZQYAssets.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit
import AssetsLibrary

class ZQYAssets: NSObject {
    
    var isSelected: Bool?
    

    var asset: ALAsset?
    /*
     较为清晰的缩略图
     **/
    var thumbImage:UIImage?{
    
        get{
        return UIImage(CGImage: (self.asset?.aspectRatioThumbnail().takeUnretainedValue())!)
        }
    
    }
    /*
     提供上传服务器的原图
     **/
    var originImage:UIImage?{
        
        get{
            return UIImage(CGImage: (self.asset?.defaultRepresentation().fullScreenImage().takeUnretainedValue())!)
        }
        
    }
    
}

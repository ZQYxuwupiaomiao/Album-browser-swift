//
//  GetPhotoesInfo.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit
import AssetsLibrary

typealias callBack = (obj: AnyObject) -> Void

class GetPhotoesInfo: NSObject {

    var nowCallBack: callBack?
    
    var assetsLibrary = ALAssetsLibrary()//资源库管理类

    static let sharedInstance = GetPhotoesInfo()
    private override init() {
        
    }
    func getAllGroupPhoto(photo: Bool,finished: callBack) -> Void {
        //获取照片组
        var mutableArray = [ZQYPhotoGroup]()
        let resultData: ALAssetsLibraryGroupsEnumerationResultsBlock = {
            (group:ALAssetsGroup!,stop) in
            
            if group != nil {
                group.setAssetsFilter(ALAssetsFilter.allPhotos())
                
                if group.numberOfAssets()>0 {
                    let nowGroup:ZQYPhotoGroup = ZQYPhotoGroup()
                    nowGroup.group = group
                    nowGroup.groupName = (group.valueForProperty("ALAssetsGroupPropertyName") as! String)
                    nowGroup.thumbImage = UIImage(CGImage: group.posterImage().takeUnretainedValue())
                    nowGroup.assetsCount = group.numberOfAssets()
                    mutableArray.append(nowGroup)
                }
                
            }else{
                finished(obj: mutableArray)
            }
            
        }
        self.assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: resultData, failureBlock: nil)
        
    }
    //MARK: 获取每一组的照片
    func getAllPhotosWithGroup(group: ZQYPhotoGroup,finished: callBack) -> Void {
        var mutableArray = [ZQYAssets]()
        let resultData: ALAssetsGroupEnumerationResultsBlock = {
            (group:ALAsset! ,index: Int, stop) in
            
            if group != nil {
                let assets: ZQYAssets = ZQYAssets()
                assets.asset = group
                assets.isSelected = false
                mutableArray.append(assets)                
            }else{
                finished(obj: mutableArray)
            }
        }
        group.group?.enumerateAssetsUsingBlock(resultData)
    }
}

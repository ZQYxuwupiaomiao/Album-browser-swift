//
//  ShowDetailPicViewController.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit
 

class ShowDetailPicViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,clickButtonInShowPicProtocol {

   private let cellID = "collectionVieCell"
    
    var group: ZQYPhotoGroup?
    private var collection: UICollectionView?
    private var dataArray = [ZQYAssets]()//装图片的集合
    var maxSelectCoun: Int?//最多可以选择的照片个数
    var selectedImageArray = [AnyObject]()//已选择的相片
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.group?.groupName
        self.view.backgroundColor = UIColor.whiteColor()
        
        createUI()//创建cellectionView
        
        initSomeData()//初始化相册数据
    }
    
    func initSomeData() {
        GetPhotoesInfo.sharedInstance.getAllPhotosWithGroup(self.group!) { (obj) in
            self.dataArray = obj as! [ZQYAssets]
            self.collection?.reloadData()
            self.collection?.scrollToItemAtIndexPath(NSIndexPath.init(forRow: self.dataArray.count-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
        }
    }
    
    func createUI() -> Void {
        let flowLayout = UICollectionViewFlowLayout()
        let width = (self.view.bounds.size.width-15)/4
        
        flowLayout.itemSize = CGSizeMake(width, width);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        
        collection = UICollectionView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height),collectionViewLayout: flowLayout)
        collection!.backgroundColor = UIColor.whiteColor();
        collection!.dataSource = self;
        collection!.delegate = self;
        collection?.registerNib(UINib.init(nibName: "ShowPicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        self.view.addSubview(collection!)
        
        ceateRightItem()
    }
    //MARK: 右边的item以及点击事件
    func ceateRightItem() {
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, 50, 40)
        if self.selectedImageArray.count > 0 {
            button.setTitle(NSString().stringByAppendingFormat("确定%d",self.selectedImageArray.count) as String, forState: UIControlState.Normal)
        }else{
            button.setTitle("确定", forState: UIControlState.Normal)
        }
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(finished), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    func finished() {
    NSNotificationCenter.defaultCenter().postNotificationName("ZQYDismissSelfRightnow", object: self.selectedImageArray)
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    //MARK: <UICollectionViewDataSource,UICollectionViewDelegate>
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ShowPicCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! ShowPicCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        let asset = self.dataArray[indexPath.row]
        for var anyObject in self.selectedImageArray {
            if anyObject.isKindOfClass(ZQYAssets) {
                let nowAsset = anyObject as! ZQYAssets
                if nowAsset.asset == asset.asset {
                    asset.isSelected = true
                }
            }
        }
        cell.changSubViewsStatus(asset, tag: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let asset:ZQYAssets = self.dataArray[indexPath.row]

        let bigPicVC:ShowBigPicsViewController = ShowBigPicsViewController()
        bigPicVC.asset = asset
       // bigPicVC.nowIndex = indexPath.row
        //bigPicVC.dataArray = self.dataArray
       // self.navigationController?.pushViewController(bigPicVC, animated: true)
        
        self.addChildViewController(bigPicVC)
        self.view.addSubview(bigPicVC.view)
    }
    
    
    
    func clickButtonInShowPic(tag: Int) {
        let indexPath = NSIndexPath(forRow:tag ,inSection: 0)
        
        let asset = self.dataArray[indexPath.row]
        let cell: ShowPicCollectionViewCell = self.collection!.cellForItemAtIndexPath(indexPath) as! ShowPicCollectionViewCell
        asset.isSelected = !asset.isSelected!
        if asset.isSelected! {
            let string = NSString(format: "最多可以选择%d张照片",maxSelectCoun!) as String
            if self.selectedImageArray.count >= maxSelectCoun {
                let alertView = UIAlertView(title: nil, message: string, delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }else{
                cell.selectedImage.image = UIImage(named: "AssetsPickerChecked")
                self.selectedImageArray.append(asset)
            }
            
        }else{
            cell.selectedImage.image = UIImage(named: "uncheck_icon")
            var a:Int = 0
            
            for var anyObject in self.selectedImageArray {
                if anyObject.isKindOfClass(ZQYAssets) {
                    let nowAsset: ZQYAssets = anyObject as! ZQYAssets
                    if nowAsset.asset == asset.asset {
                        self.selectedImageArray.removeAtIndex(a)
                        return
                    }
                }
                a += 1
            }
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

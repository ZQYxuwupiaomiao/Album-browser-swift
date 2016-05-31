//
//  ViewController.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/10.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit


class ViewController: UIViewController,sendSelectedPicsToVCProtocol,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var selectedImageArray = [AnyObject]()//已选择的相片
    private let cellID = "collectionVieCell"
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(self.view.frame.size.width/2-50, 80, 100, 40)
        button.setTitle("跳转到相册", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(gotoNextPage), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        createUI()//创建cellectionView
        
    }
    func createUI() -> Void {
        let flowLayout = UICollectionViewFlowLayout()
        let width = (self.view.bounds.size.width-15)/4
        
        flowLayout.itemSize = CGSizeMake(width, width);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        
        collectionView = UICollectionView(frame: CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height),collectionViewLayout: flowLayout)
        collectionView!.backgroundColor = UIColor.whiteColor();
        collectionView!.dataSource = self;
        collectionView!.delegate = self;
        collectionView?.registerNib(UINib.init(nibName: "ShowPicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        self.view.addSubview(collectionView!)
        
    }
    
    func gotoNextPage() {
        
        let ZQYPicsVC: ZQYPicsFirstShowViewController = ZQYPicsFirstShowViewController()
        ZQYPicsVC.maxSelectCoun = 9//最多可选的照片数
        ZQYPicsVC.selectedImageArray = self.selectedImageArray
        ZQYPicsVC.delegate = self
        ZQYPicsVC.showSelfRightNow(self)
        
    }
    //MARK: <UICollectionViewDataSource,UICollectionViewDelegate>
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedImageArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ShowPicCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! ShowPicCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        let asset = self.selectedImageArray[indexPath.row]
        for var anyObject in self.selectedImageArray {
            if anyObject.isKindOfClass(ZQYAssets) {
                cell.changSubViewsStatus(asset as! ZQYAssets, tag: indexPath.row)
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func sendSelectedpocsToVC(photos:[AnyObject]){
        
        self.selectedImageArray = photos
        self.collectionView?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


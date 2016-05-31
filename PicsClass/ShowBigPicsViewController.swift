//
//  ShowBigPicsViewController.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/16.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit


class ShowBigPicsViewController: UIViewController {

    //var nowIndex: Int?
    //var dataArray = [ZQYAssets]()
    var bigImageView: UIImageView?
    var asset: ZQYAssets?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.blackColor()
        
//        let button:UIButton = UIButton(type: UIButtonType.Custom)
//        button.frame = CGRectMake(10, 20, 40, 40)
//        button.setTitle("返回", forState: UIControlState.Normal)
//        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        button.addTarget(self, action: #selector(disMiss), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button)
        
        createUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func createUI() {
        
        showBigPic(asset!)

        
        /*
        
        let width = UIScreen.mainScreen().bounds.size.width
        let scrollView: UIScrollView = UIScrollView(frame:CGRectMake(0, 64, width, self.view.bounds.size.height-84))
        scrollView.pagingEnabled = true
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = CGSizeMake(width*CGFloat(dataArray.count), self.view.bounds.size.height-84)
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = false
        self.view.addSubview(scrollView)

        var i:Int = 0;
        for var asset:ZQYAssets in self.dataArray {
            let imageView: UIImageView = UIImageView(frame:CGRectMake(width*CGFloat(i), 0, self.view.bounds.size.width, self.view.bounds.size.height-84))
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.image = asset.originImage
            i += 1
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentOffset = CGPointMake(width*CGFloat(nowIndex!), 0)

 */
    }
    
    func showBigPic(asset:ZQYAssets) -> Void {
        if bigImageView == nil {
            bigImageView = UIImageView(frame:CGRectMake(0, self.view.bounds.size.height-84, 0, 0))
            bigImageView!.contentMode = UIViewContentMode.ScaleAspectFill
            bigImageView!.image = asset.originImage
            bigImageView?.userInteractionEnabled = true;
            self.view.addSubview(bigImageView!)
            
            UIView.animateWithDuration(0.5, animations: { 
                self.bigImageView?.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-84)
            })
            
            bigImageView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMiss)))
        }
        
    }
    
    
    
    func disMiss() {
       // self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.navigationBarHidden = false

        UIView.animateWithDuration(0.3, animations: { 
            
            self.bigImageView?.frame = CGRectMake(0, 44, 0, 0)
            self.view.frame = CGRectMake(0, 0, 0, 0)

            }) { (false) in
                self.view.removeFromSuperview()

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

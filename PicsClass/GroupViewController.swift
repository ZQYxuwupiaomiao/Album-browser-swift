//
//  GroupViewController.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit


class GroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cellID = "defaultCellID"
    
    private var tableView: UITableView?
    
    var maxSelectCoun: Int?//最多可以选择的照片个数
    var selectedImageArray = [AnyObject]()//已选择的相片

    
    //保存照片集合
   private lazy var assets = [ZQYPhotoGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "相薄"
        initPhotoInfoForAlbum()//初始化组信息
        createtableView()
        addNotification()//注册通知
        ceateRightItem()
    }
    //MARK: 右边的item以及点击事件
    func ceateRightItem() {
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, 40, 40)
        button.setTitle("取消", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(finished), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    func finished() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func test() {
        let showDetailVC = ShowDetailPicViewController()
        for var group: ZQYPhotoGroup in self.assets {
            if group.groupName == "相机胶卷" {
                showDetailVC.group = group
            }
        }
        if showDetailVC.group == nil  {
            showDetailVC.group = self.assets[0]
        }
        showDetailVC.maxSelectCoun = self.maxSelectCoun
        showDetailVC.selectedImageArray = self.selectedImageArray
        self.navigationController?.pushViewController(showDetailVC, animated: false)
    }
    
    func initPhotoInfoForAlbum() {
        
        GetPhotoesInfo.sharedInstance.getAllGroupPhoto(true) { (obj) in
            self.assets = obj as! [ZQYPhotoGroup]
            self.test()
            self.tableView?.reloadData()
        }
    }
    
    func createtableView() {
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.registerNib(UINib.init(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        self.view .addSubview(self.tableView!)
    }
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(dismissSelf), name: "ZQYDismissSelfRightnow", object: nil)
    }
    func dismissSelf(notify: NSNotification) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: tableView的代理方法的实现
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.assets.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:GroupTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellID,forIndexPath: indexPath ) as? GroupTableViewCell 
        if cell == nil {
            cell = GroupTableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: cellID)
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        cell.group = self.assets[indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showDetailVC = ShowDetailPicViewController()
        showDetailVC.group = self.assets[indexPath.row]
        showDetailVC.maxSelectCoun = self.maxSelectCoun
        showDetailVC.selectedImageArray = self.selectedImageArray
        self.navigationController?.pushViewController(showDetailVC, animated: true)
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
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

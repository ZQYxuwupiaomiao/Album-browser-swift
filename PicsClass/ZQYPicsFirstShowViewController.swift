//
//  ZQYPicsFirstShowViewController.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/16.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit

protocol sendSelectedPicsToVCProtocol {
    func sendSelectedpocsToVC(photos:[AnyObject])
}


class ZQYPicsFirstShowViewController: UIViewController {

    var maxSelectCoun: Int?//最多可以选择的照片个数
    var selectedImageArray = [AnyObject]()//已选择的相片
    var delegate: sendSelectedPicsToVCProtocol?

    var groupVC: GroupViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor()

        addNotification()
        
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        createNavigationController()
    }
    
   private func createNavigationController() {
        groupVC = GroupViewController()
        let nav: UINavigationController = UINavigationController(rootViewController: groupVC!)
        nav.view.frame = self.view.bounds
        self.addChildViewController(nav)
        self.view.addSubview(nav.view)
    }
    func showSelfRightNow(vc: UIViewController) {
        groupVC!.maxSelectCoun = self.maxSelectCoun
        groupVC?.selectedImageArray = self.selectedImageArray
        vc.presentViewController(self, animated: true, completion: nil)
    }
    
    func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(dismissSelf), name: "ZQYDismissSelfRightnow", object: nil)
    }
    func dismissSelf(notify: NSNotification) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.sendSelectedpocsToVC(notify.object as! Array)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

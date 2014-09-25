//
//  FeedViewController.swift
//  ios8_facebook_transitions
//
//  Created by Stanley Ng on 9/24/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var feedTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("FeedViewController.viewDidLoad")
        setupScrollView()
        setupTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScrollView() {
        self.contentImageView.sizeToFit()
        self.scrollView.contentSize = self.contentImageView.frame.size
    }
    
    func setupTabBar() {
        self.tabBar.selectedItem = feedTabBarItem
    }

    @IBAction func onPhotoTap(sender: UITapGestureRecognizer) {
        println("FeedViewController.onPhotoTap")
        performSegueWithIdentifier("PhotoFromFeed", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destinationViewController = segue.destinationViewController as PhotoViewController
        var imageView = sender.view as UIImageView
        destinationViewController.image = imageView.image
    }

}

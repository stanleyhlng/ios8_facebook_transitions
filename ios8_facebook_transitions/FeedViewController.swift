//
//  FeedViewController.swift
//  ios8_facebook_transitions
//
//  Created by Stanley Ng on 9/24/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var feedTabBarItem: UITabBarItem!
    var isPresenting = false
    
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

        // passing data
        var imageView = sender.view as UIImageView
        destinationViewController.image = imageView.image
        
        // customizing transition
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
    }

    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animateTransition")
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4,
                animations: {
                    () -> Void in
                    toViewController.view.alpha = 1
                },
                completion: {
                    (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                }
            )
        }
        else {
            UIView.animateWithDuration(0.4,
                animations: {
                    () -> Void in
                    fromViewController.view.alpha = 0
                },
                completion: {
                    (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                }
            )
        }
    }

}

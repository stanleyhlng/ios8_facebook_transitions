//
//  PhotoViewController.swift
//  ios8_facebook_transitions
//
//  Created by Stanley Ng on 9/24/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var actionsImageView: UIImageView!
    @IBOutlet weak var photo1ImageView: UIImageView!
    @IBOutlet weak var photo2ImageView: UIImageView!
    @IBOutlet weak var photo3ImageView: UIImageView!
    @IBOutlet weak var photo4ImageView: UIImageView!
    @IBOutlet weak var photo5ImageView: UIImageView!
    @IBOutlet weak var proxyImageView: UIImageView!
    var images: [UIImage]?
    var page: Int = 0
    var proxy: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("PhotoViewController.viewDidLoad")
        setupImages()
        setupProxy()
        setupScrollView()
        hideControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDone(sender: UIButton) {
        var idx = Int(scrollView.contentOffset.x / 320)
        proxy.image = images![idx]
        proxy.tag = idx + 1
        proxy.frame = proxyImageView.frame
        println("proxy = \(proxy)")
        dismissViewControllerAnimated(true, nil)
    }
    
    func setupControls() {
        hideControls()
    }
    
    func setupImages() {
        photo1ImageView.image = images![0]
        photo2ImageView.image = images![1]
        photo3ImageView.image = images![2]
        photo4ImageView.image = images![3]
        photo5ImageView.image = images![4]
    }
    
    func setupProxy() {
        proxy.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func setupScrollView() {
        contentView.sizeToFit()
        scrollView.contentSize = contentView.frame.size
        
        scrollView.delegate = self
        
        scrollView.contentOffset.x = CGFloat(page * 320)
    }
    
    func hideControls() {
        doneButton.alpha = 0
        actionsImageView.alpha = 0
    }
    
    func showControls() {
        doneButton.alpha = 1
        actionsImageView.alpha = 1
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //println("PhotoViewController.scrollViewDidScroll")
        
        var offset = Float(scrollView.contentOffset.y)
        //println("offset = \(offset)")
        
        var alpha = 1 - abs(convertValue(offset, r1Min: 0, r1Max: 200, r2Min: 0, r2Max: 1))
        //println("alpha = \(alpha)")
        
        scrollView.backgroundColor = UIColor(white: 0, alpha: CGFloat(alpha))
        
        // dismiss when abs(offset.y) > 120
        if abs(offset) > 120 {
            
            proxy.frame = proxyImageView.frame
            proxy.frame.origin.y -= CGFloat(offset)
            println("proxy-1: \(proxy)")
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        println("PhotoViewController.scrollViewWillBeginDragging")

        var translation = scrollView.panGestureRecognizer.translationInView(scrollView)

        UIView.animateWithDuration(0.4,
            animations: {
                () -> Void in

                if translation.y != 0 {
                    self.hideControls()
                }
                
            },
            completion: nil
        )
        
        var idx = Int(scrollView.contentOffset.x / 320)
        proxy.image = images![idx]
        proxy.tag = idx + 1
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        println("PhotoViewController.scrollViewWillEndDragging")

        var translation = scrollView.panGestureRecognizer.translationInView(scrollView)

        UIView.animateWithDuration(0.4,
            animations: {
                () -> Void in
                
                if translation.y != 0 {
                    self.showControls()
                }
                
            },
            completion: nil
        )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

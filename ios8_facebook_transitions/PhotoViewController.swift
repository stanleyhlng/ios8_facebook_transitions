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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var actionsImageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("PhotoViewController.viewDidLoad")
        setupImageView()
        setupScrollView()
        hideControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDon(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func setupControls() {
        hideControls()
    }
    
    func setupImageView() {
        imageView.image = image
    }
    
    func setupScrollView() {
        contentView.sizeToFit()
        scrollView.contentSize = contentView.frame.size
        scrollView.delegate = self
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
        println("PhotoViewController.scrollViewDidScroll")
        
        var offset = Float(scrollView.contentOffset.y)
        println("offset = \(offset)")
        
        var alpha = 1 - abs(convertValue(offset, r1Min: 0, r1Max: 300, r2Min: 0, r2Max: 1))
        println("alpha = \(alpha)")
        
        scrollView.backgroundColor = UIColor(white: 0, alpha: CGFloat(alpha))
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        println("PhotoViewController.scrollViewWillBeginDragging")
        UIView.animateWithDuration(0.4,
            animations: {
                () -> Void in
                self.hideControls()
            },
            completion: nil
        )
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        println("PhotoViewController.scrollViewWillEndDragging")
        println("PhotoViewController.scrollViewWillBeginDragging")
        UIView.animateWithDuration(0.4,
            animations: {
                () -> Void in
                self.showControls()
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

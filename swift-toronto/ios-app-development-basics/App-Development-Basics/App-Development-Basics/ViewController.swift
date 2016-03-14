//
//  ViewController.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/5/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filterView: UIButton!
    @IBOutlet var compareView: UIButton!
    
    @IBOutlet var bottomView: UIStackView!
    @IBOutlet var filtersView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image = UIImage(named: "nong-khai")
       
        // Setup filters menu
        filtersView.translatesAutoresizingMaskIntoConstraints = false
        filtersView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected){
            sender.selected = false
            hideFiltersMenu()
        } else {
            sender.selected = true
            showFiltersMenu()
        }
    }
    
    func showFiltersMenu(){
        view.addSubview(filtersView)
        
        let leftConstraint = filtersView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = filtersView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let bottomConstraint = filtersView.bottomAnchor.constraintEqualToAnchor(bottomView.topAnchor)
        let heightConstraint = filtersView.heightAnchor.constraintEqualToConstant(44)
        NSLayoutConstraint.activateConstraints([leftConstraint, rightConstraint, bottomConstraint, heightConstraint])
        view.layoutIfNeeded()
        filtersView.alpha = 0.0
        UIView.animateWithDuration(0.3, animations: {
            self.filtersView.alpha = 1.0
        })
    }
    
    func hideFiltersMenu(){
        UIView.animateWithDuration(0.3, animations: {
            self.filtersView.alpha = 0.0
            }, completion: {
                (finished:Bool) in
                if(finished) {
                    self.filtersView.removeFromSuperview()
                }
        })
    }
    
    @IBAction func onNewPhoto(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        actionSheet.popoverPresentationController?.sourceView = sender
        actionSheet.popoverPresentationController?.sourceRect = sender.bounds
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: showCamera))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: showAlbum))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera(action: UIAlertAction?){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        present(picker)
    }
    
    
    func showAlbum(action: UIAlertAction?){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        present(picker)
    }
    
    func present(viewController: UIViewController){
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onCompare(sender: UIButton) {
    }
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: ["Some text here!", imageView.image!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        activityController.popoverPresentationController?.sourceRect = sender.bounds
        presentViewController(activityController, animated: true, completion: nil)
    }

}


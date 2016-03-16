//
//  ViewController.swift
//  App-Development-Basics
//
//  Created by Nick Andrievsky on 3/5/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageStateDelegate, ProcessedImageViewDelegate, UICollectionViewDelegate {

    @IBOutlet var sourceImageView: UIImageView!
    @IBOutlet var processedImageView: ProcessedImageView!
    @IBOutlet var bottomView: UIStackView!
    @IBOutlet var editView: UIView!
    @IBOutlet var additionalView: AdditionalView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var filtersView: UIView!
    @IBOutlet var overlayLabel: UILabel!
    
    
    var state:ImageState = ImageState()
    var imageProcessor = ImageProcessor(image: UIImage(named: "nong-khai")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        sourceImageView.image = UIImage(named: "nong-khai")
       
        processedImageView.delegate = self
        state.delegate = self
        state.update()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // States Handling
    
    func changedState(state: ImageStateProperty, previousState: ImageStateProperty) {
        print("\(state) <- \(previousState)")
        shareButton?.enabled = processedImageView.isReady()
        compareButton?.enabled = processedImageView.isReady()
        compareButton.selected = state == .Compare
        processedImageView?.hidden = state == .Init
        overlayLabel.hidden = state == .Init
        filterButton.selected = state == .Filters
        editButton.selected = state == .Edit

        if previousState == .Compare {
            processedImageView.show()
        }
        
        switch state {
        case .Init:
            return
        case .Ready:
            if additionalView.isOpen(){
                additionalView.close()
            }
        case .Filters:
            return
        case .Compare:
            processedImageView.hide()
        default: return
        }
    }
    
    // Image View Delegate
    
    func processedImageViewHide(view: ProcessedImageView) {
        overlayLabel.hidden = false
    }
    
    func processedImageViewShow(view: ProcessedImageView) {
        overlayLabel.hidden = true
    }
    
    // Filters Handling
    
    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected){
            state.change(.Ready)
        } else {
            additionalView!.open(filtersView)
            state.change(.Filters)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return ImageProcessor.FILTERS.count
    }
    
    let filtersList = [
        Filter.RedContrast,
        Filter.GaussianBlur
    
    ]
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cellView:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterViewCell", forIndexPath: indexPath)
        
        var image = UIImage(named: "nong-khai")
        let size = CGSize(width: 80, height: 80)
        image = ImageUtil.resize(&image!, sizeChange: size)
        let imageProcessor = ImageProcessor(image: image!)
        let filter = filtersList[indexPath.row]
        imageProcessor.addFilter(preset: filter)
        (cellView as! FilterViewCell).imageView.image = imageProcessor.toUIImage()
        (cellView as! FilterViewCell).title.text = Filter.getTitle(filter)
        
        return cellView
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        imageProcessor.addFilter(preset: filtersList[indexPath.row])
        updateProcessedImage()
        state.change(.Ready)
    }
    
    func updateProcessedImage(){
        processedImageView.image = imageProcessor.toUIImage()
    }
    
    // New Photo Menu and Delegate
    
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
        processedImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        state.change(.Ready)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Compare Handling
    
    @IBAction func onCompare(sender: UIButton) {
        if(sender.selected){
            state.change(.Ready)
        } else {
            state.change(.Compare)
        }
    }
    
    // Share Handling
    
    @IBAction func onShare(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: ["Some text here!", sourceImageView.image!], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        activityController.popoverPresentationController?.sourceRect = sender.bounds
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // Edit Handling
    
    @IBAction func onEdit(sender: UIButton) {
        if(sender.selected){
            state.change(.Ready)
        } else {
            additionalView!.open(editView)
            state.change(.Edit)
        }
    }

    @IBAction func onEditChaged(sender: UISlider) {
        print(sender.value)
    }
}


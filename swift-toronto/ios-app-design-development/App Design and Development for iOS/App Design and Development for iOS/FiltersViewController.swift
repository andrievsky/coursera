//
//  NewImageViewController.swift
//  App Design and Development for iOS
//
//  Created by Nick Andrievsky on 4/3/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var filtersCollectionView: UICollectionView!
    @IBOutlet var imageView: ProcessedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = ImageModel.getInstance().getImage()
        
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.recreate(ImageModel.getInstance().getImage())
        filtersCollectionView.reloadData()
    }
    
    let filtersList = [
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur,
        Filter.RedContrast,
        Filter.GaussianBlur
    ]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return filtersList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cellView:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterViewCell", forIndexPath: indexPath)
        
        var image = ImageModel.getInstance().getImage()
        let size = CGSize(width: 80, height: 80)
        image = ImageUtil.resize(&image, sizeChange: size)
        let imageProcessor = ImageProcessor(image: image)
        let filter = filtersList[indexPath.row]
        imageProcessor.addFilter(preset: filter)
        (cellView as! FilterViewCell).imageView.image = imageProcessor.toUIImage()
        (cellView as! FilterViewCell).title.text = Filter.getTitle(filter)

        return cellView
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        imageView.applyFilter(filtersList[indexPath.row])
        ImageModel.getInstance().update(withImage: imageView.image!)
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

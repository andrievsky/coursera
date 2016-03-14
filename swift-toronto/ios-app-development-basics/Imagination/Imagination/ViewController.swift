//
//  ViewController.swift
//  Imagination
//
//  Created by Nick Andrievsky on 2/29/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var imageView2: UIImageView!

    @IBAction func onPress(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView2.image = nil
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image = ImageProcessor(image: UIImage(named: "sample")!).addFilter(name: "Strong Red").addFilter(name: "Weak Blur").toUIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


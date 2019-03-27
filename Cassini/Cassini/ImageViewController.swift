//
//  ViewController.swift
//  Cassini
//
//  Created by Daniel Bermudez on 3/27/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if imageURL == nil {
            imageURL = demoURL.stanford
        }
       
    }
    private var image : UIImage?{
        get {
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    var imageURL : URL? {
        didSet{
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 2.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    private func fetchImage(){
        if let url = imageURL {
            
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents{
                image = UIImage(data: imageData)
                
            }
        }
    }
}


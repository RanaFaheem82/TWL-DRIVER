//
//  PreviewMenuCollectionViewCell.swift
//  GoDesto
//
//  Created by Ghafar Tanveer on 20/03/2018.
//  Copyright © 2018 Ghafar Tanveer. All rights reserved.
//

import UIKit

class PreviewPhotoCollectionViewCell: BaseCollectionViewCell,UIScrollViewDelegate {
    
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView?.delegate = self
        self.scrollView?.minimumZoomScale = 1
        self.scrollView?.maximumZoomScale = 3
        self.scrollView?.contentInset = .zero
        self.scrollView?.scrollIndicatorInsets = .zero
        self.scrollView?.contentOffset = CGPoint(x: 0.0, y: 0.0)
        
        
    }
    
//    func configure(gallery:EventGalleryViewModel,isPhoto:Bool)  {
//        self.setImageWithUrl(imageView: self.imgPhoto , url: gallery.imagePath)
//    }
//    func configureImage(image:[String:String])  {
//        if(DeviceType.IS_IPHONE_X_All){
//            self.imgPhoto.image = UIImage(named: image["iphonex"] ?? "")
//        }else{
//            self.imgPhoto.image = UIImage(named: image["iphone"] ?? "")
//        }
//    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return  self.imgPhoto
    }
    
}

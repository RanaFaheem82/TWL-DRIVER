//
//  FruitDetailCollectionViewCell.swift
//  Tawrid
//
//  Created by Rizwan Ali on 21/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
  

class FruitDetailCollectionViewCell: BaseCollectionViewCell{
    
    @IBOutlet weak var imgImage2: UIImageView!
    weak var delegate : FruitDetailCollectionViewCellDelegate?
    @IBOutlet weak var btnFavorite: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    func configure(Product : String ,  IsFavorite : Int){
         self.setImageWithUrl(imageView: self.imgImage2!, url: Product, placeholder: AssetNames.oval)
        //  self.setImageWithUrl(imageView:  self.imgImage2!, url: Product)
        if(IsFavorite == 1){
            btnFavorite.isSelected = true
        }
        else{
             btnFavorite.isSelected = false
        }
    }
    
    @IBAction func actionAddFavorite(_ sender: Any) {
        self.btnFavorite.isSelected = !self.btnFavorite.isSelected
        
        if(self.btnFavorite.isSelected){
        if let del = self.delegate{
            del.addToFavorite(cell: self)
        }
        }
        else{
            if let del = self.delegate{
                del.removeFromFavourite()
            }
        }
        
    }
    
    
    
}


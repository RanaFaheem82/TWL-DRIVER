//
//  ProfileStatusTableViewCell.swift
//  Tawrid
//
//  Created by Rizwan Ali on 24/01/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class ProfileStatusTableViewCell: UITableViewCell {
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblbottomLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configureView(side: [String : String]){
        self.imgImage.image = UIImage(named: side["image"]!)
        self.lblTitle.text = side["title"]
    }
}

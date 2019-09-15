//
//  CustomRentCarDialog.swift
//  Cabtown
//
//  Created by Elluminati on 22/02/17.
//  Copyright © 2017 Elluminati. All rights reserved.
//

import Foundation
import UIKit




class CustomDriverDetailCell:UITableViewCell
{
    @IBOutlet var imgProfilePic: UIImageView!
    
   
    @IBOutlet var lblNameValue: UILabel!
    
   
    @IBOutlet weak var backgroundview: UIView!

    @IBOutlet weak var lblDescValue: UILabel!
    
    override func awakeFromNib() {
        
       // backgroundview.setShadow()
        lblNameValue.textColor = UIColor.themeTextColor
    
    }
    func setData(data:ProductInfo)
    {
        self.lblNameValue.text = data.productName
        self.lblDescValue.text = data.productDescription
        if data.productImage == "" {
            self.imgProfilePic.image = UIImage.init(named: "asset-placeholder")
        }else{
            self.imgProfilePic.image = Utility.getImageFromBase64(base64: data.productImage)
        }
        imgProfilePic.setRound()
    }
}

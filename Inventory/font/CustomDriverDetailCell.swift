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
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblNameValue: UILabel!
    @IBOutlet var btnRemoveDriver: UIButton!
    
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var viewactive: UIView!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var plateNumber: UILabel!
    deinit {
        printE("\(self) \(#function)")
    }
    
    override func awakeFromNib() {
        
        lblName.textColor = UIColor.themeTextColor
        
        lblName.font = FontHelper.font(size: FontSize.regular, type: FontType.Bold)
        
       // backgroundview.setShadow()
        lblNameValue.textColor = UIColor.themeTextColor
       // lblNameValue.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
      //  btnRemoveDriver.setImage(UIImage.init(named: "asset-image"), for: .normal)
        
        
        btnRemoveDriver.setImage(nil, for: .normal)
        btnRemoveDriver.setImage(nil, for: .selected)
        btnRemoveDriver.setTitleColor(UIColor.themeImageColorSpecial, for: .normal)
        btnRemoveDriver.setTitleColor(UIColor.themeImageColorSpecial, for: .selected)
        btnRemoveDriver.titleLabel?.font = FontHelper.assetFont(size: btnRemoveDriver.titleLabel?.font.pointSize ?? FontSize.regular)
      //  btnRemoveDriver.setSimpleIconButton()
        
        serviceType.textColor = UIColor.themeLightTextColor
        serviceType.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)

        plateNumber.textColor = UIColor.themeLightTextColor
        plateNumber.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
        
        lblMake.textColor = UIColor.themeLightTextColor
        lblMake.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
        
        lblModel.textColor = UIColor.themeLightTextColor
        lblModel.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
        
        lblYear.textColor = UIColor.themeLightTextColor
        lblYear.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
        
        lblColor.textColor = UIColor.themeLightTextColor
        lblColor.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
        
    }
    func setData(data:Provider)
    {
        lblNameValue.text = data.firstName + " " + data.lastName
        
        serviceType.text = data.typeDetails.typename!
        lblMake.text = data.vehicleDetail.first!.model!
        lblModel.text = data.vehicleDetail.first!.model!
        lblYear.text = data.vehicleDetail.first!.passingYear!
        lblColor.text = data.vehicleDetail.first!.color!
        plateNumber.text = data.vehicleDetail.first!.plateNo!
        imgProfilePic.downloadedFrom(link: data.picture)
//        
        if (data.isActive! == 1 && data.isAvailable == 1) {

            self.viewactive.backgroundColor = UIColor.green
            self.viewactive.layer.cornerRadius = self.viewactive.frame.height / 2
            
        }else if (data.isActive! == 0 && data.isAvailable == 1){
            
            self.viewactive.backgroundColor = UIColor.red
            self.viewactive.layer.cornerRadius = self.viewactive.frame.height / 2
            
        }else if (data.isActive! == 1 && data.isAvailable == 0){
            
            self.viewactive.backgroundColor = UIColor.red
            self.viewactive.layer.cornerRadius = self.viewactive.frame.height / 2
            
        }else{
            self.viewactive.backgroundColor = UIColor.red
            self.viewactive.layer.cornerRadius = self.viewactive.frame.height / 2
        }
        
        imgProfilePic.setRound()
    }
}

//
//  myAppColors.swift
//  Cabtown
//
//  Created by Elluminati on 30/01/17.
//  Copyright © 2017 Elluminati. All rights reserved.
//
import UIKit

extension UIColor
{
    var imageRepresentation : UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 320.0, height:64.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    //Custom Button Colors
    static let themeButtonBackgroundColor:UIColor = UIColor(red:  19/255, green: 30/255, blue: 47/255, alpha: 1.0)
     static let themeGooglePathColor:UIColor = UIColor(red:  71/255, green: 170/255, blue: 255/255, alpha: 1.0)
    static let themeButtonTitleColor:UIColor = UIColor(red:236/255, green:236/255 ,blue:255/255 , alpha:1.00)
    static let themeSelectionColor:UIColor = UIColor(red:  0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
  
    static let themeSwitchTintColor:UIColor =  UIColor(red:  0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    
    //Custom TextFieldColors
    static let themeActiveTextColor:UIColor = UIColor(red:  0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    static let themeErrorTextColor:UIColor = UIColor(red:220/255, green:74/255 ,blue:48/255 , alpha:1.0)
    static let themeTextColor:UIColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    static let themeLightTextColor:UIColor = UIColor(red:0/255, green:0/255 ,blue:0/255 , alpha:0.5)
  
    //NavigationBar Colors
    static let themeTitleColor:UIColor = UIColor(red:0/255, green:0/255 ,blue:0/255 , alpha:1.00)
    static let themeNavigationBackgroundColor:UIColor = UIColor(red: 19/255, green: 30/255, blue: 47/255, alpha: 1.0)
    static let navigationTitlColor : UIColor = UIColor(red:236/255, green:236/255 ,blue:236/255 , alpha:1.00)
    static let themeIconColor : UIColor =  UIColor(red:19/255, green:30/255 ,blue:47/255 , alpha:1.00)
    //Theme Dialog Colors
    static let themeOverlayColor:UIColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 0.8)
    static let themeDialogBackgroundColor:UIColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    
    static let themeViewBackgroundColor:UIColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    static let themeDividerColor:UIColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        static let themeLightDividerColor:UIColor = UIColor(red:136/255, green:139/255 ,blue:136/255 , alpha:0.7)
    
    static let themeShadowColor:UIColor = UIColor(red: 160/255.0, green: 160/255.0, blue: 160/255.0, alpha: 1.0)
    
    
    
    static let themeWalletDeductedColor:UIColor = UIColor(red:230/255, green:65/255 ,blue:67/255 , alpha:1.00)
    
    static let themeWalletAddedColor:UIColor = UIColor(red:87/255, green:142/255 ,blue:18/255 , alpha:1.00)
    
    static let themeWalletBGColor:UIColor = UIColor(red:236/255, green:236/255 ,blue:236/255 , alpha:0.60)
    
    static let themeSenderBGColor:UIColor = UIColor(red:201/255, green:206/255 ,blue:241/255 , alpha:1.0)
    
    static let themeReceiverBGColor:UIColor = UIColor(red:211/255, green:241/255 ,blue:201/255 , alpha:1.0)
    
 }

//MARK:- Font Helper

struct FontSize
{
    static let navigationTitle:CGFloat = 22;
    static let button:CGFloat = 22;
    
    static let small:CGFloat = 14;
    static let tiny:CGFloat = 12;
    static let regular:CGFloat = 16;
    static let medium:CGFloat = 18;
    static let large:CGFloat = 20
    static let extraLarge:CGFloat = 24;
    static let doubleExtraLarge:CGFloat = 36;
}
/*enum FontType
    {
        case Bold
        case Light
        case Regular
}



class FontHelper:UIFont
{
    class func font(size: CGFloat = FontSize.regular,type:FontType) -> UIFont
    {
        
        switch type
            {
            case .Bold:
                return UIFont(name: "Roboto-Bold", size: size)!
            case .Light:
                return UIFont(name: "Roboto_Regular_0", size: size)!
            case .Regular:
                return UIFont(name: "Roboto_Regular_0", size: size)!
            }
    }
}*/


//
//  CustomPhotoDialog.swift
//  Cabtown
//
//  Created by Elluminati on 22/02/17.
//  Copyright © 2017 Elluminati. All rights reserved.
//

import Foundation
import UIKit


public class CustomTotalDialog:CustomDialog
{
    //MARK:- OUTLETS
    @IBOutlet weak var stkDialog: UIStackView!
    @IBOutlet weak var stkBtns: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var viewForCalulation: UIView!
   
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblQuantityValue: UILabel!
    @IBOutlet weak var lblCurrentRate: UILabel!
    @IBOutlet weak var lblCurrentRateValue: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalValue: UILabel!
    
    //MARK:Variables
    var onClickRightButton : ((_ cancelReason:String) -> Void)? = nil
    var onClickLeftButton : (() -> Void)? = nil
    static let  TotalDialog = "dialogForTotal"
    
    
    
    public static func  showCustomTotalDialog
        (title:String,
         message:String,
         quantity:Double,
         currentRate:Double,
         titleLeftButton:String,
         titleRightButton:String
        ) ->
        CustomTotalDialog
    {
        
        
        let view = UINib(nibName: TotalDialog, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomTotalDialog
  
        view.alertView.setShadow()
        view.alertView.backgroundColor = UIColor.white
//         view.backgroundColor = UIColor.clear
        let frame = (APPDELEGATE.window?.frame)!;
        view.frame = frame;
        view.lblTitle.text = title;
        
        view.lblMessage.text = message;
        view.setLocalization()
        view.btnLeft.setTitle(titleLeftButton.capitalized, for: UIControl.State.normal)
        view.btnRight.setTitle(titleRightButton.capitalized, for: UIControl.State.normal)
        if let view = (APPDELEGATE.window?.viewWithTag(400))
        {
            UIApplication.shared.keyWindow?.bringSubviewToFront(view);
        }
        else
        {
            UIApplication.shared.keyWindow?.addSubview(view)
            UIApplication.shared.keyWindow?.bringSubviewToFront(view);
        }
        view.btnLeft.isHidden =  titleLeftButton.isEmpty()
        view.btnRight.isHidden =  titleRightButton.isEmpty()
        view.lblTitle.isHidden = title.isEmpty()
        view.lblMessage.isHidden = message.isEmpty()
        view.lblQuantityValue.text = String(quantity)
        view.lblCurrentRateValue.text =  String(currentRate)
        view.lblTotalValue.text = String(quantity * currentRate)
        
        return view;
    }
    
    func setLocalization(){
        btnLeft.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnRight.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnRight.backgroundColor = UIColor.white
        lblTitle.textColor = UIColor.black
        lblMessage.textColor = UIColor.black
        //    btnRight.setupButton()
        /* Set Font */
        //        btnLeft.titleLabel?.font =  FontHelper.font(type: FontType.Regular)
        //        btnRight.titleLabel?.font =  FontHelper.font(size: FontSize.medium, type: FontType.Regular)
        //        lblTitle.font = FontHelper.font(size: FontSize.large, type: FontType.Bold)
        //        lblMessage.font = FontHelper.font(type: FontType.Regular)
        //
        
        self.backgroundColor = UIColor.themeOverlayColor
        self.alertView.backgroundColor = UIColor.white
        self.viewForCalulation.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
         self.alertView.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    
    //ActionMethods
    
    @IBAction func onClickBtnLeft(_ sender: Any)
    {
        if self.onClickLeftButton != nil
        {
            self.onClickLeftButton!();
        }
        
    }
    @IBAction func onClickBtnRight(_ sender: Any)
    {
        if self.onClickRightButton != nil
        {
            
            self.onClickRightButton!(lblTotalValue.text!)
        }
        
    }
    
}



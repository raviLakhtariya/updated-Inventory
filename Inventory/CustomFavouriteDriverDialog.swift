//
//  CustomTableDialog.swift
//  edelivery
//
//  Created by Elluminati on 24/02/17.
//  Copyright © 2017 Elluminati. All rights reserved.
//

import UIKit
class CustomFavouriteDriverDialog: CustomDialog, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate
{
    
    struct Identifiers
    {
        static let  FavouriteDriverDialog = "dialogForFavouriteDriver"
        static let  CellForFavouriteDriver = "CustomDriverDetailCell"
        static let  reuseCellIdentifier = "cell"
    }
    //MARK:- Outlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableForProvider: UITableView!
    
    @IBOutlet var lblIconSearch: UILabel!
    
    @IBOutlet weak var alertView: UIView!

    var providerlist:[Provider] = [];
    var filteredProviders = [Provider]()
    var onProviderSelected : ((_ provider:Provider) -> Void)? = nil
    
    override func awakeFromNib()
    {
        lblTitle.font = FontHelper.font(size: FontSize.large, type: FontType.Regular)
        lblTitle.textColor = UIColor.themeTextColor
        txtSearch.font = FontHelper.font(size: FontSize.medium, type: FontType.Regular)
//        lblIconSearch.text = FontAsset.icon_search
//lblIconSearch.setForIcon()
        
    }
    public static func  showCustomFavouriteDialog(arrForProvider : [Provider]) -> CustomFavouriteDriverDialog
    {
        let view = UINib(nibName: Identifiers.FavouriteDriverDialog, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomFavouriteDriverDialog
        
        view.alertView.setShadow()
        view.alertView.setRound(withBorderColor: UIColor.lightText, andCornerRadious: 10.0, borderWidth: 0.5)
        view.tableForProvider.delegate = view;
        view.tableForProvider.dataSource = view;
       // view.txtSearch.delegate = view as! UITextFieldDelegate;
//view.txtSearch.placeholder = "TXT_SEARCH_COUNTRY".localized
        view.providerlist = arrForProvider//CurrentTrip.shared.arrForProviders
        view.filteredProviders = arrForProvider//CurrentTrip.shared.arrForProviders
        view.tableForProvider.register(UINib.init(nibName: Identifiers.CellForFavouriteDriver, bundle: nil), forCellReuseIdentifier: Identifiers.reuseCellIdentifier)
        view.tableForProvider.tableFooterView = UIView.init()
        let frame = (UIApplication.shared.keyWindow?.frame)!;
        view.frame = frame
        UIApplication.shared.keyWindow?.addSubview(view)
        UIApplication.shared.keyWindow?.bringSubviewToFront(view);
        return view;
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let provider:Provider = filteredProviders[indexPath.row]
        if self.onProviderSelected != nil
        {
            self.onProviderSelected!(provider)
        }
        self.removeFromSuperview();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if filteredProviders.count > 0
        {
            return filteredProviders.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.reuseCellIdentifier, for: indexPath) as! CustomDriverDetailCell;
        
        let provider:Provider = filteredProviders[indexPath.row]
        cell.btnRemoveDriver.isHidden = true
        cell.setData(data: filteredProviders[indexPath.row])
      return cell
        
//        cell.lblCountryName.text = country.countryName
//        cell.lblCountryPhoneCode.text = country.countryPhoneCode
//
//        return cell
//    }
    }
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    @IBAction func onClickBtnClose(_ sender: Any)
    {
        self.removeFromSuperview();
    }
    @IBAction func searching(_ sender: Any) {
        let text = txtSearch.text!.lowercased()
        if text.isEmpty
        {
            filteredProviders.removeAll()
            filteredProviders.append(contentsOf: providerlist)
        }
        else
        {
            filteredProviders.removeAll()
            for provider in providerlist
            {
                guard let email = provider.email else
                {
                    return
                }
                if  email.lowercased().hasPrefix(text)
                {
                    filteredProviders.append(provider)
                }
                
            }
        }
        tableForProvider.reloadData()
        
    }
    
    
    

   
}


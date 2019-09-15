//
//  CustomTableDialog.swift
//  edelivery
//
//  Created by Elluminati on 24/02/17.
//  Copyright © 2017 Elluminati. All rights reserved.
//

import UIKit
class CustomFavouriteDriverDialog: CustomDialog, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate
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
    
 
    
    @IBOutlet weak var alertView: UIView!

    var productslist:[ProductInfo] = [];
    var filteredProducts = [ProductInfo]()
    var onProductsSelected : ((_ product:ProductInfo) -> Void)? = nil
    
    override func awakeFromNib()
    {
     
        lblTitle.textColor = UIColor.themeTextColor
        
 
        
    }
    public static func  showCustomFavouriteDialog(arrForProduct : [ProductInfo]) -> CustomFavouriteDriverDialog
    {
        let view = UINib(nibName: Identifiers.FavouriteDriverDialog, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomFavouriteDriverDialog
        
        view.alertView.setShadow()
        view.alertView.setRound(withBorderColor: UIColor.lightText, andCornerRadious: 10.0, borderWidth: 0.5)
        view.tableForProvider.delegate = view;
        view.tableForProvider.dataSource = view;
        view.txtSearch.delegate = view as UITextFieldDelegate;
        view.txtSearch.placeholder = "Search Products"//"TXT_SEARCH_COUNTRY".localized
        view.productslist = arrForProduct//CurrentTrip.shared.arrForProviders
        view.filteredProducts = arrForProduct//CurrentTrip.shared.arrForProviders
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
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product:ProductInfo = filteredProducts[indexPath.row]
        if self.onProductsSelected != nil
        {
            self.onProductsSelected!(product)
        }
        self.removeFromSuperview();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if filteredProducts.count > 0
        {
            return filteredProducts.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:Identifiers.reuseCellIdentifier, for: indexPath) as! CustomDriverDetailCell;
        
        let product:ProductInfo = filteredProducts[indexPath.row]
       
        cell.setData(data: filteredProducts[indexPath.row])
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
            filteredProducts.removeAll()
            filteredProducts.append(contentsOf: productslist)
        }
        else
        {
            filteredProducts.removeAll()
            for product in productslist
            {
                guard var productName = product.productName as? String else
                {
                    return
                }
                if  productName.lowercased().hasPrefix(text)
                {
                    filteredProducts.append(product)
                }
                
            }
        }
        tableForProvider.reloadData()
        
    }
   
}


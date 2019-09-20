//
//  CounterVC.swift
//  Inventory
//
//  Created by Janki on 20/09/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit
import UICircularProgressRing
class CounterVC: UIViewController {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var navigationTitle: UILabel!
    
    
    @IBOutlet weak var totalInverdView: UIView!
    @IBOutlet weak var totalOutverdView: UIView!
    @IBOutlet weak var totalTransactionView: UIView!
    
    @IBOutlet weak var totalInwardLbl: UILabel!
    @IBOutlet weak var totalOutwardLbl: UILabel!
    @IBOutlet weak var totalTransactionLbl: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productIDLbl: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productIDValue: UILabel!
    @IBOutlet weak var productnameValue: UILabel!
    
    @IBOutlet weak var totalInverdValueLbl: UILabel!
    
    @IBOutlet weak var totalTransactionValueLbl: UILabel!
    
    @IBOutlet weak var totalOutwardValueLbl: UILabel!
    
    var arrTransactionInfo : NSMutableArray!
    var arrproductInfo : NSMutableArray!
    var countInverd : Int = 0
    var countOutverd : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        arrproductInfo = NSMutableArray()
        arrproductInfo = ModelManager.getInstance().getAllProductData()
        productImg.setRound()
        totalInverdView.setShadow()
        totalOutverdView.setShadow()
        totalTransactionView.setShadow()
        totalTransactionValueLbl.setShadow()
        totalOutwardValueLbl.setShadow()
        totalInverdValueLbl.setShadow()
//        totalTransactionRing.minValue = 0
//        totalOutwardRing.minValue = 0
//        totalInverdRing.minValue = 0
//
//        totalTransactionRing.maxValue = 100
//        totalOutwardRing.maxValue = 100
//        totalInverdRing.maxValue = 100
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        openSelectProduct()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    @IBAction func onClickSelectProductBtn(_ sender: Any) {
        openSelectProduct()
    }
    func openSelectProduct(){
        self.view.endEditing(true)
        
        let dialogForSelectProduct  = CustomFavouriteDriverDialog.showCustomFavouriteDialog(arrForProduct:arrproductInfo as! [ProductInfo])
        dialogForSelectProduct.onProductsSelected =
            { [unowned self, unowned dialogForSelectProduct]
                (product:ProductInfo) in
                self.countInverd = 0
                self.countOutverd = 0
                self.productIDValue.text = String(product.productID)
                self.productnameValue.text = product.productName
                if product.productImage == "" {
                    self.productImg.image = UIImage.init(named: "asset-placeholder")
                }else{
                    self.productImg.image = Utility.getImageFromBase64(base64: product.productImage)
                }
                self.getSpecificTransaction(productid: product.productID)
                dialogForSelectProduct.removeFromSuperview()
        }
    }
    func getSpecificTransaction(productid:Int){
        arrTransactionInfo = NSMutableArray()
        arrTransactionInfo = ModelManager.getInstance().getSpecificInverdData(ID: productid)
        totalTransactionValueLbl.text = String(self.arrTransactionInfo.count)
      //  totalTransactionRing.value = CGFloat(Float(self.arrTransactionInfo!.count))
        for i in 0..<arrTransactionInfo.count{
            var inverdObject : Inverd = arrTransactionInfo[i] as! Inverd
            if inverdObject.isinverd == true{
                countInverd = countInverd + 1
            }else{
                countOutverd = countOutverd + 1
            }
        }
        totalInverdValueLbl.text = String(countInverd)
        totalOutwardValueLbl.text = String(countOutverd)
        //    totalInverdRing.value = CGFloat(Float(countInverd))
     //   totalOutwardRing.value = CGFloat(Float(countOutverd))
    }
}

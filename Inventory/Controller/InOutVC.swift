//
//  InOutVC.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class InOutVC: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var datebtn: UIButton!
    @IBOutlet weak var imgAddView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detailAddView: UIView!
  
    @IBOutlet weak var txtProductRate: UITextField!
    @IBOutlet weak var txtProductQuantity: UITextField!
    @IBOutlet weak var lblproductTotal: UILabel!
    
    @IBOutlet weak var lblProductNameTitle: UILabel!
    @IBOutlet weak var lblProductQuantityTitle: UILabel!
    @IBOutlet weak var lblProductRateTitle: UILabel!
    @IBOutlet weak var lblProductTotalTitle: UILabel!
    
    @IBOutlet weak var lblProductNameValue: UILabel!
    @IBOutlet weak var lblProductQuantityValue: UILabel!
    @IBOutlet weak var lblProductRateValue: UILabel!
    @IBOutlet weak var lblProductTotalValue: UILabel!
    
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnTotal: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    
    var strDateOfEarning:String = "";
    
    var isEdit : Bool = false
    var productData : ProductInfo!
    var inverdData : Inverd!
   
    var isInverd : Bool!
    var productIds : Int!
    var productDesc : String!
    var productDate : String!

    var arrProductInfos : NSMutableArray!
    var isNull : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        
        // Do any additional setup after loading the view.
    }
    func getProductData()
    {
        arrProductInfos = NSMutableArray()
        arrProductInfos = ModelManager.getInstance().getAllProductData()
    }
    func initialSetup(){
        self.imgView.clipsToBounds = true
        self.imgView.layer.cornerRadius = self.imgView.frame.height / 2.0
        
        getProductData()
        currentDate()
        checkIsInverdOrOutverd()
        
        
        if isInverd == true {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
            navigationController?.navigationBar.barTintColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
            navigationView.backgroundColor = UIColor.init(red: 0/255.0, green: 130.0/255.0, blue: 0/255.0, alpha: 1.0)
        }else{
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            navigationController?.navigationBar.barTintColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            navigationView.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // self.initialSetup()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtProductQuantity {
            self.txtProductQuantity.becomeFirstResponder()
        }
        if textField == txtProductRate{
            self.txtProductRate.becomeFirstResponder()
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtProductQuantity {
            self.txtProductQuantity.resignFirstResponder()
            
            if txtProductQuantity.text == "" {
                Utility.showToast(message: "Please Enter product Quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
        }
        else if textField == txtProductRate {
            self.txtProductRate.resignFirstResponder()
            if txtProductRate.text == "" {
                Utility.showToast(message: "Please Enter product Rate", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
        }
        
        if txtProductRate.text != "" && txtProductQuantity.text != "" {
            
            self.lblproductTotal.text = String(Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!) ?? 0.0, rate: Double(txtProductRate.text!) ?? 0.0))
        }
//        }else if txtProductRate.text == "" && txtProductQuantity.text != "" {
//            Utility.showToast(message: "Please Enter product Rate", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }else if txtProductRate.text != "" && txtProductQuantity.text == "" {
//            Utility.showToast(message: "Please Enter product Quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }else{
//            Utility.showToast(message: "Please Enter product Quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }
        
    }
    func setupWhileIsEditFalse(){
        txtProductQuantity.text = "0.0"
        txtProductRate.text = "0.0"
        lblproductTotal.text = "0.0"
    }
    func checkIsInverdOrOutverd(){
        if isInverd == true {
            
            if isEdit == true {
                
                productIds = inverdData!.productID
                arrProductInfos = NSMutableArray()
                arrProductInfos = ModelManager.getInstance().getSpecificProductData(ID: inverdData!.productID)
                print(arrProductInfos.count)
                
                let products = arrProductInfos.object(at: 0) as! ProductInfo
                productDesc = products.productDescription
                productDate = products.productDate
                lblProductRateValue.text = String(products.productCurrentRate)
                lblProductQuantityValue.text = String(products.productQuantity)
                lblProductTotalValue.text = String(inverdData.inproductTotal)
                lblProductTotalValue.text = String(products.productTotal)
                          self.dateLbl.text = products.productDate//Utility.convertDateFormate(date: products.productDate)
           //     dateLbl.setTitle(products.productDate, for: .normal)
                if products.productImage != "" {
                    imgView.image = Utility.getImageFromBase64(base64: products.productImage)
                }else{
                    imgView.image = UIImage.init(named: "asset-placeholder")
                }
                
                dateLbl.text = inverdData.inproductDate
                txtProductRate.text = String(inverdData.inproductCurrentRate)
                txtProductQuantity.text = String(inverdData.inproductQuantity)
                lblproductTotal.text = String(inverdData.inproductTotal)
                
            }else{
                
                    setupWhileIsEditFalse()
                if arrProductInfos.count == 0 {
                    addController()
                    //            Utility.showToast(message: "Please Add product First", backgroundColor: UIColor.black, textColor: UIColor.white)
                    self.view.isUserInteractionEnabled = false
                }else{
                    self.view.isUserInteractionEnabled = true
                    openSelectProduct()
                    
                }
                //                    openSelectProduct()
            }
        }else {
            
            if isEdit == true {
                productIds = inverdData!.productID
                arrProductInfos = NSMutableArray()
                arrProductInfos = ModelManager.getInstance().getSpecificProductData(ID: inverdData!.productID)
                print(arrProductInfos.count)
                
                let products = arrProductInfos.object(at: 0) as! ProductInfo
                productDesc = products.productDescription
                productDate = products.productDate
                lblProductRateValue.text = String(products.productCurrentRate)
                lblProductQuantityValue.text = String(products.productQuantity)
                lblProductTotalValue.text = String(products.productTotal)
                  self.dateLbl.text = products.productDate//Utility.convertDateFormate(date: products.productDate)
              //  dateLbl.setTitle(products.productDate, for: .normal)
                if products.productImage != "" {
                    imgView.image = Utility.getImageFromBase64(base64: products.productImage)
                }else{
                    imgView.image = UIImage.init(named: "asset-placeholder")
                }
                
                dateLbl.text = inverdData.inproductDate
                txtProductRate.text = String(inverdData.inproductCurrentRate)
                txtProductQuantity.text = String(inverdData.inproductQuantity)
                 lblproductTotal.text = String(inverdData.inproductTotal)

            }else  {
                        setupWhileIsEditFalse()
                if arrProductInfos.count == 0 {
                    addController()
                    //            Utility.showToast(message: "Please Add product First", backgroundColor: UIColor.black, textColor: UIColor.white)
                    self.view.isUserInteractionEnabled = false
                }else{
                    self.view.isUserInteractionEnabled = true
                    openSelectProduct()
                    
                }
                
                }
            }
        }
    
    
    
    func openSelectProduct(){
        self.view.endEditing(true)
       
        let dialogForProvider  = CustomFavouriteDriverDialog.showCustomFavouriteDialog(arrForProduct:arrProductInfos as! [ProductInfo])
        dialogForProvider.onProductsSelected =
            { [unowned self, unowned dialogForProvider]
                (product:ProductInfo) in
                self.productIds = product.productID
                self.productDesc = product.productDescription
                self.productDate = product.productDate
                self.lblProductNameValue.text = product.productName
                self.lblProductQuantityValue.text = String(product.productQuantity)
                self.lblProductRateValue.text = String(product.productCurrentRate)
                self.lblProductTotalValue.text = String(product.productTotal)
                if product.productImage == "" {
                    self.imgView.image = UIImage.init(named: "asset-placeholder")
                }else{
                    self.imgView.image = Utility.getImageFromBase64(base64: product.productImage)
                }
                dialogForProvider.removeFromSuperview()
            }
    }
    
    
    @IBAction func onClickSelectProduct(_ sender: Any) {
        openSelectProduct()
     /*   if arrProductInfos.count == 0 {
           addController()
//            Utility.showToast(message: "Please Add product First", backgroundColor: UIColor.black, textColor: UIColor.white)
            self.view.isUserInteractionEnabled = false
        }else{
            self.view.isUserInteractionEnabled = true
            openSelectProduct()

        }*/
    }
    func addController(){
        let controller : UIAlertController = UIAlertController.init(title: "Product", message: "Please Add product First", preferredStyle: .alert)
        let action : UIAlertAction = UIAlertAction.init(title: "Ok", style: .default) { (void) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
    func currentDate(){
        let date = Date()
        let formatter = DateFormatter()
        self.strDateOfEarning = Utility.dateToString(date: date, withFormat: DateFormat.DATE_MM_DD_YYYY)
        self.dateLbl.text = Utility.convertDateFormate(date: date)
        //    self.datebtn.setTitle(Utility.convertDateFormate(date: date), for: .normal)
    }
    
    @IBAction func onClickBtnTotal(_ sender: Any) {
        self.view.endEditing(true)
        let dialogForTotal = CustomTotalDialog.showCustomTotalDialog(title: "Calculate Your Amount", message: "", quantity: Double(txtProductQuantity.text!) ?? 0.0, currentRate:  Double(txtProductRate.text!) ?? 0.0, titleLeftButton: "Cancel", titleRightButton: "Ok")
        
        dialogForTotal.onClickLeftButton =
            {
                dialogForTotal.removeFromSuperview();
        }
        dialogForTotal.onClickRightButton = { (reason) in
            self.lblproductTotal.isHidden = false
            self.lblproductTotal.text = reason
            dialogForTotal.removeFromSuperview();
        }
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
  
    
    @IBAction func onClickDatePicker(_ sender: Any) {
        self.openDatePicker()
    }
    
    func openDatePicker()
    {
        self.view.endEditing(true)
        
        let datePickerDialog:CustomDatePickerDialog = CustomDatePickerDialog.showCustomDatePickerDialog(title: "Select Date"/*.localized*/, titleLeftButton: "Cancel"/*.localized*/, titleRightButton: "Select"/*.localized*/)
    //    datePickerDialog.setMaxDate(maxdate: Date())
        datePickerDialog.onClickLeftButton =
            { [unowned datePickerDialog] in
                datePickerDialog.removeFromSuperview()
        }
        datePickerDialog.onClickRightButton =
            { [unowned self, unowned datePickerDialog] (selectedDate:Date) in
                self.strDateOfEarning = Utility.dateToString(date: selectedDate, withFormat: DateFormat.DATE_MM_DD_YYYY)
                self.dateLbl.text = Utility.convertDateFormate(date: selectedDate)
                //  self.dateLbl.setTitle(Utility.convertDateFormate(date: selectedDate), for: .normal)
                datePickerDialog.removeFromSuperview()
        }
    }

 
    @IBAction func onClickChooseUpdate(_ sender: Any) {
        if txtProductRate.text == "" && txtProductQuantity.text == "" {
            Utility.showToast(message: "Please enter product current rate", backgroundColor: UIColor.white, textColor: UIColor.black)
        }else if txtProductRate.text == "" && txtProductQuantity.text != ""  {
                       Utility.showToast(message: "Please enter product current rate", backgroundColor: UIColor.white, textColor: UIColor.black)
        }else if txtProductRate.text != "" && txtProductQuantity.text == "" {
                        Utility.showToast(message: "Please enter product quantity", backgroundColor: UIColor.white, textColor: UIColor.black)
        }else{
            if isInverd == true {
                
                saveInverdData()
            }else{
                saveOutverdData()
            }
        }
       
    }

    @IBAction func onClickCancel(_ sender: Any) {
        self.txtProductQuantity.text = ""
        self.txtProductRate.text = ""
     self.lblproductTotal.text = "0.0"
    }

    func saveInverdData(){
        if isEdit == false {
            let inverdInfo: Inverd = Inverd()
            
            inverdInfo.isinverd = true
            inverdInfo.productID = productIds
            inverdInfo.inproductCurrentRate = Double(txtProductRate.text!)!
            inverdInfo.inproductQuantity = Int(txtProductQuantity.text!)!
            inverdInfo.inproductTotal = Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!)
            inverdInfo.inproductDate = dateLbl.text!
            
            let isUpdated = saveProductData(productID: productIds, inQuantity: Int(txtProductQuantity.text!)!, inRate: Double(lblProductRateValue.text!)!, inTotal: Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!),isInverd:true)
            
            if isUpdated == true{
                
                let isInserted = ModelManager.getInstance().addInwardData(inwardInfo: inverdInfo)
                if isInserted {
                    
                    
                    Utility.showToast(message: "Record Inserted successfully.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    Utility.showToast(message: "Error in inserting record.")
                }
                
            }else{
                Utility.showToast(message: "Error in inserting record.")
            }
        }else{
            let inverdInfo: Inverd = Inverd()
            
            inverdInfo.isinverd = true
            inverdInfo.productID = productIds
            inverdInfo.inproductCurrentRate = Double(txtProductRate.text!)!
            inverdInfo.inproductQuantity = Int(txtProductQuantity.text!)!
            inverdInfo.inproductTotal = Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!)
            inverdInfo.inproductDate = dateLbl.text!
            
            let isUpdated = saveProductData(productID: productIds, inQuantity: Int(txtProductQuantity.text!)!, inRate: Double(lblProductRateValue.text!)!, inTotal: Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!),isInverd:true)
            
            if isUpdated == true{
                
                let isUpdate = ModelManager.getInstance().updateInwardData(inwardInfo: inverdInfo)
                if isUpdate {
                    
                    
                    Utility.showToast(message: "Record Updated successfully.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    Utility.showToast(message: "Error in inserting record.")
                }
                
            }else{
                Utility.showToast(message: "Error in inserting record.")
            }
        }
      
    }
    
    func saveOutverdData(){
        if isEdit == false {
            let inverdInfo: Inverd = Inverd()
            inverdInfo.isinverd = false
            inverdInfo.productID = productIds
            inverdInfo.inproductCurrentRate = Double(txtProductRate.text!)!
            inverdInfo.inproductQuantity = Int(txtProductQuantity.text!)!
            inverdInfo.inproductTotal = Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!)
            inverdInfo.inproductDate = dateLbl.text!
            
            let isUpdated = saveProductData(productID: productIds, inQuantity: Int(txtProductQuantity.text!)!, inRate: Double(lblProductRateValue.text!)!, inTotal: Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!),isInverd:false)
            
            if isUpdated == true {
                let isInserted = ModelManager.getInstance().addInwardData(inwardInfo: inverdInfo)
                if isInserted {
                    
                    
                    Utility.showToast(message: "Record Inserted successfully.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    Utility.showToast(message: "Error in inserting record.")
                }
            }else{
                Utility.showToast(message: "Error in inserting record.")
            }
        }else{
            let inverdInfo: Inverd = Inverd()
            inverdInfo.isinverd = false
            inverdInfo.productID = productIds
            inverdInfo.inproductCurrentRate = Double(txtProductRate.text!)!
            inverdInfo.inproductQuantity = Int(txtProductQuantity.text!)!
            inverdInfo.inproductTotal = Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!)
            inverdInfo.inproductDate = dateLbl.text!
            
            let isUpdated = saveProductData(productID: productIds, inQuantity: Int(txtProductQuantity.text!)!, inRate: Double(lblProductRateValue.text!)!, inTotal: Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!)!, rate: Double(txtProductRate.text!)!),isInverd:false)
            
            if isUpdated == true {
                let isUpdate = ModelManager.getInstance().updateInwardData(inwardInfo: inverdInfo)
                if isUpdate {
                    
                    
                    Utility.showToast(message: "Record Updated successfully.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    Utility.showToast(message: "Error in inserting record.")
                }
            }else{
                Utility.showToast(message: "Error in inserting record.")
            }
        }
       
        
        
    }
    
    
    func saveProductData(productID:Int,inQuantity:Int,inRate:Double,inTotal:Double,isInverd:Bool)->Bool{
        
            let productInfo: ProductInfo = ProductInfo()
            productInfo.productID = productIds
            productInfo.productName = self.lblProductNameValue.text!
            productInfo.productDescription = productDesc
            productInfo.productDate = productDate
        productInfo.productCurrentRate = Double(self.lblProductRateValue.text!)!
        
            if imgView.image == UIImage.init(named: "asset-placeholder") {
                productInfo.productImage = ""
            }else{
                let productStrImage = Utility.convertImageToBase64(image: imgView.image!)
                productInfo.productImage = productStrImage
            }
        
        if isInverd == true {
            productInfo.productQuantity = ((Int(self.lblProductQuantityValue.text!)!) + inQuantity)
      
            productInfo.productTotal = ((Double(self.lblProductTotalValue.text!)!) + inTotal)
             //  productInfo.productCurrentRate = inverdRateCalucation(inverdProductTotal: ((Double(self.lblProductTotalValue.text!)!) + inTotal), inverdProductQuantity: ((Int(self.lblProductQuantityValue.text!)!) + inQuantity))
        }else{
            
            productInfo.productQuantity = ((Int(self.lblProductQuantityValue.text!)!) - inQuantity)
           
           // productInfo.productCurrentRate = ((Double(self.lblProductRateValue.text!)!) - inRate)
            productInfo.productTotal = ((Double(self.lblProductTotalValue.text!)!) - inTotal)
        }
        
        if productInfo.productQuantity < 0 {
             Utility.showToast(message: "You have not sufficient Stock")
            return false
        }else{
            let isUpdated = ModelManager.getInstance().updateProductData(productInfo: productInfo)
            if isUpdated {
                Utility.showToast(message: "Record Inserted successfully.")
                return true
            //    self.navigationController?.popViewController(animated: true)
            } else {
                Utility.showToast(message: "Error in inserting record.")
                return false
            }
        }
        
    }
    
    func inverdRateCalucation(inverdProductTotal:Double,inverdProductQuantity:Int)->Double{
        return (inverdProductTotal / Double(inverdProductQuantity))
    }
}

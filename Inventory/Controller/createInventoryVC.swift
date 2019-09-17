//
//  createInventoryVC.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class createInventoryVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var dateBtn: UIButton!
    
    @IBOutlet weak var imgAddView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detailAddView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductDesc: UITextField!
    @IBOutlet weak var txtProductRate: UITextField!
    @IBOutlet weak var txtProductQuantity: UITextField!
    @IBOutlet weak var lblproductTotal: UILabel!
    var strToDate:String = ""
    var dialogForImage:CustomPhotoDialog?;
    var isPicAdded:Bool!
    var strDateOfEarning:String = "";
    var imgProduct : UIImage!
    @IBOutlet weak var cancelBtn: UIButton!
    var isEdit : Bool = false
    var productData : ProductInfo!
    var total : Double!
    
    var isNamefill : Bool!
    var isDescription : Bool!
    var isProductQuantity : Bool!
    var isProductRate : Bool!
    var imgads : UIImage!
    @IBOutlet weak var yourTotalBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 44/255.0, green: 80/255.0, blue: 137/255.0, alpha: 1.0)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.initialSetup()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtProductName {
            self.txtProductName.becomeFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtProductDesc {
            self.txtProductDesc.resignFirstResponder()
        }
        
        if textField == txtProductQuantity {
            self.txtProductQuantity.resignFirstResponder()
            
            if txtProductQuantity.text == "" {
                 Utility.showToast(message: "Please Enter product Quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
        }
        if textField == txtProductRate {
            self.txtProductRate.resignFirstResponder()
            
            if txtProductRate.text == "" {
                Utility.showToast(message: "Please Enter product Rate", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
        }
        
        if txtProductRate.text != "" && txtProductQuantity.text != "" {
         
         self.lblproductTotal.text = String(Utility.calculateQntyCurrency(qnty: Double(txtProductQuantity.text!) ?? 0.0, rate: Double(txtProductRate.text!) ?? 0.0))
    
        }
        //else if txtProductRate.text == "" && txtProductQuantity.text != "" {
//            Utility.showToast(message: "Please Enter product Rate", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }else if txtProductRate.text != "" && txtProductQuantity.text == "" {
//             Utility.showToast(message: "Please Enter product Quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }else{
//                 Utility.showToast(message: "Please Enter product Quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }
    }
    
    
    
    func initialSetup(){
        
        
        if isEdit == true {
            
            txtProductName.text = productData.productName;
            txtProductDesc.text = productData.productDescription
            txtProductQuantity.text = String(productData.productQuantity)
            txtProductRate.text = String(productData.productCurrentRate)
            lblTitle.text = productData.productDate
            lblproductTotal.text = String(productData.productTotal)
            if productData.productImage != "" {
                if productData.productImage == "asset-placeholder"  {
                    print("placeholder")
                }
                imgView.image = Utility.getImageFromBase64(base64: productData.productImage)
                self.cancelBtn.isHidden = false
                
            }else{
                imgView.image = UIImage.init(named: "asset-placeholder")
                self.cancelBtn.isHidden = true
            }
        }else{
            if isPicAdded == false {
                imgView.image = UIImage.init(named: "asset-placeholder")

            }
            else{
                
            }
            self.cancelBtn.isHidden = true
            lblproductTotal.text = "0.0"
            imgView.setRound()
        }
      
        
//        self.imgView.clipsToBounds = true
//        self.imgView.layer.cornerRadius = self.imgView.frame.height / 2.0
        currentDate()
        
      
        
    
    }
 /*   func calculateQntyCurrency(qnty:Double,rate:Double)->Double{
        total = Double(qnty) * Double(rate)
        
        self.lblproductTotal.text = "\(total ?? 0.0)"
        return total
    }
    */
    func currentDate(){
        let date = Date()
        let formatter = DateFormatter()
        self.strDateOfEarning = Utility.dateToString(date: date, withFormat: DateFormat.DATE_MM_DD_YYYY)
        
        self.lblTitle.text = Utility.convertDateFormate(date: date)
    }
    
    
    
  /*
    @IBAction func onClickTotalBtn(_ sender: Any) {
        self.view.endEditing(true)
        let dialogForTotal = CustomTotalDialog.showCustomTotalDialog(title: "Calculate Your Amount", message: "", quantity: Double(txtProductQuantity.text!) ?? 0.0, currentRate:  Double(txtProductRate.text!) ?? 0.0, titleLeftButton: "Cancel", titleRightButton: "Ok")
        //    let dialogForTotal = CustomTotalDialog.showCustomCancelTripDialog(title: "Calculate your amount", message: "", cancelationCharge: "0", titleLeftButton: "TXT_CANCEL".localized, titleRightButton: "Ok"/*"TXT_OK".localized*/)
        
        
        dialogForTotal.onClickLeftButton =
            {
                
                dialogForTotal.removeFromSuperview();
        }
        dialogForTotal.onClickRightButton = { (reason) in
           
            self.lblproductTotal.text = reason
           dialogForTotal.removeFromSuperview();
            
        }
    }*/
    @IBAction func onClickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickBtnChoosePicture(_ sender: Any) {
        let addImageVcObj : AddImgVC = self.storyboard?.instantiateViewController(withIdentifier: "addimgvc") as! AddImgVC
        if imgView.image == UIImage.init(named: "asset-placeholder") {
            addImageVcObj.imageadded = imgView.image
            addImageVcObj.isPickAdded = false

        }else{
            addImageVcObj.imageview.image = imgView.image
            addImageVcObj.isPickAdded = true

        }
        
        self.navigationController?.pushViewController(addImageVcObj, animated: true)
        //  openImageDialog()
    }
    @IBAction func onClickBtnCancelImg(_ sender: Any) {
        imgView.image = UIImage.init(named: "asset-placeholder")
        self.cancelBtn.isHidden = true
        self.isPicAdded = false
        dialogForImage?.removeFromSuperview()

    }
    
    @IBAction func onClickBtnDate(_ sender: Any) {
        openDatePicker()
    }
    
    
    @IBAction func onClickBtnSave(_ sender: Any) {
        self.view.endEditing(true)
      
    
        
        if (txtProductName.text != "") &&  (txtProductDesc.text != "") && (txtProductQuantity.text != "") && (txtProductRate.text != "") {
             saveData()
         
        }else if (txtProductName.text == "") &&  (txtProductDesc.text == "") && (txtProductQuantity.text == "") && (txtProductRate.text == "") {
            Utility.showToast(message: "Please enter product name", backgroundColor: UIColor.black, textColor: UIColor.white)
        }
        else{
            if txtProductName.text == "" {
                Utility.showToast(message: "Please enter product name", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
            if txtProductDesc.text == "" {
                Utility.showToast(message: "Please enter product description", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
            if txtProductQuantity.text == "" {
                Utility.showToast(message: "Please enter product quantity", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
            if txtProductRate.text == "" {
                Utility.showToast(message: "Please enter product rate", backgroundColor: UIColor.black, textColor: UIColor.white)
            }else{
                
            }
        }
       
        
        
        
       
        
    }
    
    
    func saveData(){
        
        if isEdit == true {
        
            let productInfo: ProductInfo = ProductInfo()
       //     productInfo.productID = productData.productID
            productInfo.productName = txtProductName.text!
            productInfo.productDescription = txtProductDesc.text!
            productInfo.productQuantity = Int(txtProductQuantity.text!)!
            productInfo.productCurrentRate = Double(txtProductRate.text!)!
            productInfo.productTotal = Utility.calculateQntyCurrency(qnty: Double(Int(productData!.productQuantity)), rate: productData.productCurrentRate)
            productInfo.productDate = lblTitle.text!
            if imgView.image == UIImage.init(named: "asset-placeholder") {
                        productInfo.productImage = ""
            }else{
                let productStrImage = Utility.convertImageToBase64(image: imgView.image!)
                productInfo.productImage = productStrImage
            }
            
            
               let isUpdated = ModelManager.getInstance().updateProductData(productInfo: productInfo)
            if isUpdated {
                Utility.showToast(message: "Product updated successfully.")
                self.navigationController?.popViewController(animated: true)
            } else {
                Utility.showToast(message: "Error in updated product record.")
            }
            
        }
        else{
        
            let productInfo: ProductInfo = ProductInfo()
            productInfo.productName = txtProductName.text!
            productInfo.productDescription = txtProductDesc.text!
            productInfo.productQuantity = Int(txtProductQuantity.text!)!
            productInfo.productCurrentRate = Double(txtProductRate.text!)!
              productInfo.productTotal = Utility.calculateQntyCurrency(qnty: Double(Int(txtProductQuantity.text!)!), rate: Double(txtProductRate.text!)!)
            productInfo.productDate = lblTitle.text!
            if imgView.image == UIImage.init(named: "asset-placeholder") {
                    productInfo.productImage = ""
            }else{
                let productStrImage = Utility.convertImageToBase64(image: imgView.image!)
                productInfo.productImage = productStrImage
            }
            
            
            
            let isInserted = ModelManager.getInstance().addProductData(productInfo: productInfo)
            if isInserted {
                Utility.showToast(message: "Product Inserted successfully.")
                self.navigationController?.popViewController(animated: true)
            } else {
                Utility.showToast(message: "Error in inserting product.")
            }
            
        }
        
    }
    
    
    
    func openDatePicker()
    {
        self.view.endEditing(true)
        
        let datePickerDialog:CustomDatePickerDialog = CustomDatePickerDialog.showCustomDatePickerDialog(title: "Select Date"/*.localized*/, titleLeftButton: "Cancel"/*.localized*/, titleRightButton: "Select"/*.localized*/)
   //     datePickerDialog.setMaxDate(maxdate: Date())
        datePickerDialog.onClickLeftButton =
            { [unowned datePickerDialog] in
                datePickerDialog.removeFromSuperview()
        }
        
        datePickerDialog.onClickRightButton =
            { [unowned self, unowned datePickerDialog] (selectedDate:Date) in
                self.strDateOfEarning = Utility.dateToString(date: selectedDate, withFormat: DateFormat.DATE_MM_DD_YYYY)
                //self.lblTitle.setTitle(Utility.convertDateFormate(date: selectedDate), for: .normal)
               self.lblTitle.text = Utility.convertDateFormate(date: selectedDate)
                datePickerDialog.removeFromSuperview()
        }
        
        
    }
    @IBAction func onClickBtnCancel(_ sender: Any) {
        self.txtProductName.text = ""
        self.txtProductDesc.text = ""

        self.txtProductQuantity.text = ""

        self.txtProductRate.text = ""
        self.imgView.image = UIImage.init(named: "asset-placeholder")
        self.isPicAdded = false
        self.lblproductTotal.text = "0.0"
        
    }
    func openImageDialog(){
        dialogForImage = CustomPhotoDialog.showPhotoDialog("Select image"/*.localized*/, andParent: self)
        dialogForImage?.onImageSelected = { [unowned self, weak dialogForImage = self.dialogForImage]
            (image:UIImage) in
            self.imgView.image = image
            self.isPicAdded = true
            dialogForImage?.removeFromSuperviewAndNCObserver()
            dialogForImage = nil
        }
    }
    @IBAction func saveNames(segue: UIStoryboardSegue) {
        let addimagevco:AddImgVC = segue.source as! AddImgVC
        
        if addimagevco.imageview.image == UIImage.init(named: "asset-placeholder") {
            imgView.image = addimagevco.imageadded!
            isPicAdded = addimagevco.isPickAdded!
            
        }else{
            imgads = addimagevco.imageadded!
            imgView.image = imgads!
            isPicAdded = addimagevco.isPickAdded!
            print(isPicAdded)
        }
        
        
    }
/*    func createnotification(){
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
        notification.alertBody = "Your video : " + "\(videoPlayName)" + "is saved!"
        notification.alertAction = "Ok" //  used in UIAlert button or 'slide to unlock...' slider in place of unlock
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["customParameterKey_from": "Sergey"] // Array of custom parameters
        notification.applicationIconBadgeNumber = 1
        UIApplication.shared.scheduleLocalNotification(notification)
    }*/
}

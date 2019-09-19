//
//  TransactionVC.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class TransactionVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productTotal: UILabel!
    @IBOutlet weak var productRate: UILabel!
    @IBOutlet weak var productDate: UILabel!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableview: UITableView!
    var arrTransactionInfo : NSMutableArray!
    var arrproductInfo : NSMutableArray!
    var arrProductInfos : NSMutableArray!
    var strDateOfEarning:String = "";
    
    @IBOutlet var filterView: UIView!
    @IBOutlet weak var filterNavigationView: UIView!
    @IBOutlet weak var filterBackBtn: UIButton!
    @IBOutlet weak var filterLblTitle: UILabel!
    @IBOutlet weak var filtermainnview: UIView!
    
    
    @IBOutlet weak var selectProductLbl: UILabel!
    @IBOutlet weak var selectProductView: UIView!
    @IBOutlet weak var selectProductBtn: UIButton!
    
    @IBOutlet weak var selectDateView: UIView!
    @IBOutlet weak var selectDateLbl: UILabel!
    @IBOutlet weak var selectDateBtn: UIButton!
    
    
    
    @IBOutlet weak var stackForDate: UIStackView!
    @IBOutlet weak var viewForFrom: UIView!
    @IBOutlet weak var viewForTo: UIView!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var lblIconCalender: UILabel!
    @IBOutlet var lblIconToCalender: UILabel!

    
    var strToDate:String = ""
    var strFromDate:String = ""

    
    var selectedProductID : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.frame = view.bounds
        self.view.addSubview(filterView)
        filtermainnview.setShadow()
        filtermainnview.clipsToBounds = true
        filtermainnview.layer.cornerRadius = 10.0
        selectDateBtn.clipsToBounds = true
        selectProductBtn.layer.cornerRadius = 10.0
        selectDateBtn.clipsToBounds = true
        selectDateBtn.layer.cornerRadius = 10.0//  self.selectProductView.setShadow()
      //  self.selectDateView.setShadow()
        
         
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        filterView.isHidden = true
        filterLblTitle.text = "Filter"
        filterNavigationView.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
        navigationView.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
        getProductData()
        getTransactionData()
    }
  
    func getTransactionData()
    {
        arrTransactionInfo = NSMutableArray()
        arrTransactionInfo = ModelManager.getInstance().getAllInwardData()
        tableview.reloadData()
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrTransactionInfo == nil {
            Utility.showToast(message: "No transaction found", backgroundColor: UIColor.black, textColor: UIColor.white)
            return 0
        }else{
            return arrTransactionInfo.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllTransactionCell = tableView.dequeueReusableCell(withIdentifier: "alltranscell") as! AllTransactionCell
        
        let transactionProduct:Inverd = arrTransactionInfo.object(at: indexPath.row) as! Inverd
        
       
        
        arrproductInfo = ModelManager.getInstance().getSpecificProductData(ID:transactionProduct.productID)
        
        let productObj : ProductInfo = arrproductInfo.firstObject as! ProductInfo
         cell.lblProductTitle.text = transactionProduct.inproductDate
        cell.lblProductDesc.text = String(transactionProduct.inproductTotal)
        
        if transactionProduct.isinverd == true {
           
            cell.lblProductRate.text = "+"+"\(String(transactionProduct.inproductCurrentRate))"
            cell.lblProductQuantity.text = "+"+"\(String(transactionProduct.inproductQuantity))"
            
            cell.lblProductQuantity.textColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
            cell.lblProductRate.textColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
            cell.inverdOroutverd.backgroundColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
        }else{
            
            cell.lblProductRate.text = "-"+"\(String(transactionProduct.inproductCurrentRate))"
            cell.lblProductQuantity.text = "-"+"\(String(transactionProduct.inproductQuantity))"
            
            cell.inverdOroutverd.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            cell.lblProductQuantity.textColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            cell.lblProductRate.textColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        }
        
        if productObj.productImage != "" {
            cell.productImgView.image = Utility.getImageFromBase64(base64: productObj.productImage)
        }else{
            cell.productImgView.image = UIImage.init(named: "asset-placeholder")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//       /*  for i in 0..<arrTransactionInfo.count {
//            var objs : Inverd = self.arrTransactionInfo.object(at: i) as! Inverd
//            if strDateOfEarning == objs.inproductDate {
//                    return strDateOfEarning
//                
//            }
//        }*/
//        return currentDate()
//    }
    
    func openSelectProduct(){
        self.view.endEditing(true)
        
        let dialogForProvider  = CustomFavouriteDriverDialog.showCustomFavouriteDialog(arrForProduct:arrProductInfos as! [ProductInfo])
        dialogForProvider.onProductsSelected =
            { [unowned self, unowned dialogForProvider]
                (product:ProductInfo) in
                self.selectProductBtn.setTitle(product.productName, for: .normal)
               // self.selectProductLbl.text = product.productName
                self.productName.text = product.productName
                self.productQuantity.text = String(product.productQuantity)
                self.productTotal.text = String(product.productTotal)
                self.productRate.text = String(product.productCurrentRate)
                self.productDate.text = product.productDate
                self.selectedProductID = product.productID
                self.arrTransactionInfo = NSMutableArray.init()
                
               // self.selectDateBtn.titleLabel?.text = "Select Date"
                
                
                
                self.arrTransactionInfo = ModelManager.getInstance().getSpecificInverdData(ID: product.productID)
                self.tableview.reloadData()
                
                
                dialogForProvider.removeFromSuperview()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
        
    }
    func getProductData()
    {
        arrProductInfos = NSMutableArray()
        arrProductInfos = ModelManager.getInstance().getAllProductData()
        openSelectProduct()
    }
    
    func currentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
       /* self.strDateOfEarning =*/ return Utility.convertDateFormate(date: date)//Utility.dateToString(date: date, withFormat: DateFormat.DATE_MM_DD_YYYY)
     //   self.dateLbl.text = Utility.convertDateFormate(date: date)
        //    self.datebtn.setTitle(Utility.convertDateFormate(date: date), for: .normal)
    }
    
    func CreateHeaderSection(){
        for i in 0..<arrTransactionInfo.count {
            var objs : Inverd = self.arrTransactionInfo.object(at: i) as! Inverd
            if strDateOfEarning == objs.inproductDate {
                
            }else if strDateOfEarning <= objs.inproductDate {
                
            }else if strDateOfEarning >= objs.inproductDate {
                
            }
        }
    }

    @IBAction func onClickFilterBtn(_ sender: Any) {
        self.filterView.isHidden = false
        self.selectDateBtn.titleLabel?.text! = " -- "
        self.selectProductBtn.titleLabel?.text! = " -- "
    }
    
    @IBAction func onClickFilterBackBtn(_ sender: Any) {
        self.filterView.isHidden = true
    }
    
    @IBAction func onClickSelectProductBtn(_ sender: Any) {
        openSelectProduct()
    }
    
    @IBAction func onClickSelectDateBtn(_ sender: Any) {
        openDatePicker()
    }
    
    
    func openDatePicker()
    {
        let datePickerDialog:CustomDatePickerDialog = CustomDatePickerDialog.showCustomDatePickerDialog(title: "Select Date"/*.localized*/, titleLeftButton: "Cancel"/*.localized*/, titleRightButton: "Select"/*.localized*/)
      //  datePickerDialog.setMaxDate(maxdate: Date())
        datePickerDialog.onClickLeftButton =
            { [unowned datePickerDialog] in
                datePickerDialog.removeFromSuperview()
        }
        datePickerDialog.onClickRightButton =
            { [unowned self, unowned datePickerDialog] (selectedDate:Date) in
                self.strDateOfEarning = Utility.dateToString(date: selectedDate, withFormat: DateFormat.DATE_MM_DD_YYYY)
                self.selectDateBtn.setTitle(Utility.convertDateFormate(date: selectedDate), for: .normal)
           //     self.selectDateLbl.text = Utility.convertDateFormate(date: selectedDate)
                self.arrTransactionInfo = ModelManager.getInstance().getSpecificInverdDataWithDate(ID: self.selectedProductID, date: (self.selectDateBtn.titleLabel?.text)!)
                self.tableview.reloadData()
              //  getSpecificInverdDataWithDate
//                self.selectDateLbl.setTitle(Utility.convertDateFormate(date: selectedDate), for: .normal)
                datePickerDialog.removeFromSuperview()
        }
    }
    
    
    @IBAction func onClickFromTo(_ sender: UIButton)
    {
        if sender.tag == 10
        {
            let datePickerDialog:CustomDatePickerDialog = CustomDatePickerDialog.showCustomDatePickerDialog(title: "Select form date", titleLeftButton: "Cancel", titleRightButton: "Ok")
            datePickerDialog.setMaxDate(maxdate: Date())
            if !strToDate.isEmpty()
            {
                let maxDate = strToDate.toDate(format: DateFormat.DATE_MM_DD_YYYY)
                datePickerDialog.setMaxDate(maxdate: maxDate)
            }
            datePickerDialog.onClickLeftButton =
                { [/*unowned self,*/ unowned datePickerDialog] in
                    datePickerDialog.removeFromSuperview()
            }
            
            datePickerDialog.onClickRightButton =
                { [unowned self, unowned datePickerDialog] (selectedDate:Date) in
                    
                    self.strFromDate = selectedDate.toString(withFormat: DateFormat.DATE_MM_DD_YYYY)
                    self.btnFrom.setTitle(String(format: "%@",self.strFromDate), for: UIControl.State.normal)
                    datePickerDialog.removeFromSuperview()
            }
        }
        else
        {
            if btnFrom.titleLabel?.text == "Form date"
                
            {
                let alertController = UIAlertController(title: "Warning", message: "Invalid date", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                })
                alertController.addAction(yesAction)
                present(alertController, animated: true, completion: nil)
            }
            else
            {
                let datePickerDialog:CustomDatePickerDialog = CustomDatePickerDialog.showCustomDatePickerDialog(title: "Select to date", titleLeftButton: "Cancel", titleRightButton: "Ok")
                
                let minidate = strFromDate.toDate(format: DateFormat.DATE_MM_DD_YYYY)
                
                datePickerDialog.setMaxDate(maxdate: Date())
                datePickerDialog.setMinDate(mindate: minidate)
                datePickerDialog.onClickLeftButton =
                    { [/*unowned self,*/ unowned datePickerDialog] in
                        datePickerDialog.removeFromSuperview()
                }
                
                datePickerDialog.onClickRightButton =
                    { [unowned self, unowned datePickerDialog] (selectedDate:Date) in
                        
                        self.strToDate = selectedDate.toString(withFormat: DateFormat.DATE_MM_DD_YYYY)
                        self.btnTo.setTitle(String(format: "%@",self.strToDate), for: UIControl.State.normal)
                        datePickerDialog.removeFromSuperview()
                }
                
            }
        }
    }

    
    @IBAction func onClickBtnResetFilter(_ sender: UIButton)
    {
        strToDate = "";
        strFromDate = "";
      //  self.wsGetHistory(startDate: strFromDate, endDate: strToDate);
    }
    @IBAction func onClickBtnApplyFilter(_ sender: UIButton)
    {
        if (strFromDate.isEmpty() || strToDate.isEmpty())
        {
            Utility.showToast(message: "Please select date first");
            
        }
        else
        {
        //    self.wsGetHistory(startDate: strFromDate, endDate: strToDate);
        }
        
    }

}

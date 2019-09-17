//
//  InverdVC.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class InverdVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var onAddInward: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var isEdit : Bool = false
    var productData : ProductInfo!
    var inverdData : Inverd!
    var outverdData : OutverdInfo!
    var isInverd : Bool!
    
    var arrForSection = NSMutableArray()
    var arrForCreateAt = NSMutableArray()
    var arrsort = NSMutableArray()

    var arrinverdInfo : NSMutableArray!
    var arrproductInfo : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    func initialSetup(){
        self.onAddInward.clipsToBounds = true
        onAddInward.layer.cornerRadius = self.onAddInward.frame.height / 2.0
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0/255.0, green: 130/255.0, blue: 0/255.0, alpha: 1.0)
        navigationView.backgroundColor = UIColor.init(red: 0/255.0, green: 130.0/255.0, blue: 0/255.0, alpha: 1.0)
        
        
        self.onAddInward.setShadow()
        getProductData()
    }
    func getProductData()
    {
        arrinverdInfo = NSMutableArray()
        arrinverdInfo = ModelManager.getInstance().getInverdspecificData()
       // createSection()
      tableview.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialSetup()
    }
    @IBAction func onCLickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
  
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if arrinverdInfo == nil {
//            return 0
//        }else{
//            return arrinverdInfo.count
//        }
//
//    }
//
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let inwardCellObj : inwardCell = tableView.dequeueReusableCell(withIdentifier: "inwardCell") as! inwardCell
//
//        let inverdproduct:Inverd = arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
//
//        inwardCellObj.inProductRate.text = String(inverdproduct.inproductCurrentRate)
//        inwardCellObj.inProductquantity.text = String(inverdproduct.inproductQuantity)
//
//        arrproductInfo = ModelManager.getInstance().getSpecificProductData(ID:inverdproduct.productID)
//
//        let productObj : ProductInfo = arrproductInfo.firstObject as! ProductInfo
//        inwardCellObj.inProductName.text = productObj.productName
//        inwardCellObj.inProductDesc.text = productObj.productDescription
//
//        if productObj.productImage != "" {
//            inwardCellObj.inProductImage.image = Utility.getImageFromBase64(base64: productObj.productImage)
//        }else{
//            inwardCellObj.inProductImage.image = UIImage.init(named: "asset-placeholder")
//        }
//
//        return inwardCellObj
//    }
    
    func findSpecificData(){
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete
        {
         //   let inproduct:Inverd = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! Inverd
           
            let inproduct:Inverd = arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
            
            
            let isDeleted = ModelManager.getInstance().deleteInwardData(inwardInfo: inproduct)
            if isDeleted {
                
                arrproductInfo = ModelManager.getInstance().getSpecificProductData(ID:inproduct.productID)
                let productObj : ProductInfo = arrproductInfo.firstObject as! ProductInfo
             
                productObj.productQuantity = Int(productObj.productQuantity - inproduct.inproductQuantity)
                
                productObj.productTotal = Double(productObj.productTotal - inproduct.inproductTotal)
                productObj.productCurrentRate = inverdRateCalucationDeletion(inverdProductTotal:productObj.productTotal , inverdProductQuantity: productObj.productQuantity)
                
                let isUpdated = ModelManager.getInstance().updateProductData(productInfo: productObj)
                if isUpdated {
                  // Utility.showToast(message: "Record Inserted successfully.")
                  //  self.navigationController?.popViewController(animated: true)
                } else {
                   Utility.showToast(message: "Error in inserting inward.")
                }
                
                Utility.showToast(message: "inward deleted successfully.")
            } else {
                Utility.showToast(message: "Error in deleting inward.")
            }
            self.getProductData()
        }
    }
    func inverdRateCalucationDeletion(inverdProductTotal:Double,inverdProductQuantity:Int)->Double{
        return (inverdProductTotal / Double(inverdProductQuantity))
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let inOutvcObj : InOutVC = self.storyboard?.instantiateViewController(withIdentifier: "InOutvc") as! InOutVC
//         inOutvcObj.inverdData = arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
//
//        inOutvcObj.isEdit = true
//       inOutvcObj.isInverd = true
//        self.navigationController?.pushViewController(inOutvcObj, animated: true)
//    }
//
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        if arrForSection.count > 0 {
//            return self.arrForSection.count
//
//        }else{
//            Utility.showToast(message: "No record found", backgroundColor: UIColor.black, textColor: UIColor.white)
//        }
//        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if arrinverdInfo == nil {
            return 0
        }else{
            return arrinverdInfo.count
        }
     //   return (((arrForSection .object(at: section)) as! NSMutableArray).count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let inwardCellObj : inwardCell = tableView.dequeueReusableCell(withIdentifier: "inwardCell") as! inwardCell
       
       // let dict : Inverd = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! Inverd
     
        let dict:Inverd = arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
        

        
            inwardCellObj.inProductImage.setRound()
                inwardCellObj.inProductRate.text = String(dict.inproductCurrentRate)
                inwardCellObj.inProductquantity.text = String(dict.inproductQuantity)
        
     
        
                inwardCellObj.lblproductRate.text = String("Current rate - \(dict.inproductCurrentRate)")
            inwardCellObj.lblproductQuantity.text = String("Quantity - \(dict.inproductQuantity) items")
                arrproductInfo = ModelManager.getInstance().getSpecificProductData(ID:dict.productID)
        
                let productObj : ProductInfo = arrproductInfo.firstObject as! ProductInfo
                inwardCellObj.inProductName.text = productObj.productName
                inwardCellObj.inProductDesc.text = productObj.productDescription
        
                if productObj.productImage != "" {
                    inwardCellObj.inProductImage.image = Utility.getImageFromBase64(base64: productObj.productImage)
                }else{
                    inwardCellObj.inProductImage.image = UIImage.init(named: "asset-placeholder")
                }
        
        
        
        
        return inwardCellObj
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 35
//    }
  /*  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }*/
  /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "inverdheadercell")! as! inverdHeaderCell
        
        if (arrForSection[section] as! NSMutableArray).count > 0
        {
            let dict = ((arrForSection .object(at: section)) as! NSMutableArray).object(at: 0) as! Inverd
         //   = convertedArray.sort({ $0.compare($1) == .OrderedDescending })
          //  var ready = (arrForSection[section] as! NSMutableArray).sorted(by: { $0.compare($1) == .orderedDescending })
            
         //   sectionHeader.setData(title:(arrForSection[section] as! NSMutableArray).sort({$0.companre($1) == .orderedDescending}))
        
            
           sectionHeader.setData(title: dict.inproductDate)
                  // sectionHeader.setData(title: Utility.relativeDateStringForDate(strDate: Utility.stringToString(strDate: dict.inproductDate, fromFormat: DateFormat.DATE_MM_DD_YYYY, toFormat: DateFormat.DATE_FORMAT)) as String)
        }
        
        return sectionHeader
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
  //      let dict = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! Inverd
        
        
        let inOutvcObj : InOutVC = self.storyboard?.instantiateViewController(withIdentifier: "InOutvc") as! InOutVC
      //  inOutvcObj.inverdData = dict//arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
      //  inOutvcObj.inverdData = arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
        inOutvcObj.inverdData = arrinverdInfo.object(at: (arrinverdInfo.count - 1) - indexPath.row) as! Inverd
        inOutvcObj.isEdit = true
        inOutvcObj.isInverd = true
        self.navigationController?.pushViewController(inOutvcObj, animated: true)
     
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func onClickBtnOnward(_ sender: Any) {
        let inOutvcObj : InOutVC = self.storyboard?.instantiateViewController(withIdentifier: "InOutvc") as! InOutVC
        inOutvcObj.isEdit = false
        inOutvcObj.isInverd = true
        self.navigationController?.pushViewController(inOutvcObj, animated: true)
    }
    
    
    //MARK: Create for section
    func createSection()
    {
        arrForSection.removeAllObjects()
        let arrtemp = NSMutableArray()
        arrtemp.addObjects(from: (self.arrinverdInfo as NSArray) as! [Any])
        for i in 0 ..< arrtemp.count
        {
            let dict:Inverd = arrtemp .object(at: i) as! Inverd
            let strDate:String = dict.inproductDate
            let arr = strDate .components(separatedBy:"T")
            let str:String = (arr as NSArray) .object(at: 0) as! String
            
            if(!arrForCreateAt .contains(str))
            {
                arrForCreateAt.add(str)
            }
        }
        for j in 0 ..< arrForCreateAt.count
        {
            let strTempDate:String = arrForCreateAt .object(at: j) as! String
            let arr1 = NSMutableArray()
            
            for i in 0 ..< arrtemp.count
            {
                let dict:Inverd = arrtemp .object(at: i) as! Inverd
                let strDate:String = dict.inproductDate
                let arr = strDate .components(separatedBy:"T")
                let str:String = (arr as NSArray) .object(at: 0) as! String
                if(str == strTempDate)
                {
                    arr1.add(dict)
                }
            }
            if arr1.count > 0
            {
               print(arr1.object(at: 0))
                arrForSection.add(arr1)
                
            }
            

            
        }
        self.tableview.reloadData()
    }
}


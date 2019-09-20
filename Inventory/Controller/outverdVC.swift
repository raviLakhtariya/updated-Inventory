//
//  outverdVC.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class outverdVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var onAddoutward: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var arroutverdInfo : NSMutableArray!
    var arrproductInfo : NSMutableArray!
    
    var arrForSection = NSMutableArray()
    var arrForCreateAt = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup(){

        onAddoutward.clipsToBounds = true
        onAddoutward.layer.cornerRadius = self.onAddoutward.frame.height / 2.0
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
     
        
         navigationController?.navigationBar.barTintColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        navigationView.backgroundColor = UIColor.init(red: 130/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        
        self.onAddoutward.setShadow()
        getProductData()
    }
    
    func getProductData()
    {
        arroutverdInfo = NSMutableArray()
        arroutverdInfo = ModelManager.getInstance().getOutverdSpecificData()
       //  createSection()
        tableview.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialSetup()
    }
    @IBAction func onCLickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        if arrForSection.count > 0 {
//            return self.arrForSection.count
//
//        }else{
//
//            Utility.showToast(message: "No record found", backgroundColor: UIColor.black, textColor: UIColor.white)
//         return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return (((arrForSection .object(at: section)) as! NSMutableArray).count)
        if arroutverdInfo == nil {
            return 0
        }else{
            return arroutverdInfo.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let outwardCellObj : outwerdCell = tableView.dequeueReusableCell(withIdentifier: "outwerdcell") as! outwerdCell
       let outverdproduct : Inverd = arroutverdInfo.object(at: (arroutverdInfo.count - 1) - indexPath.row) as! Inverd
        
        
        outwardCellObj.lblProductRate.text = String("Current rate - \(outverdproduct.inproductCurrentRate)")
        outwardCellObj.lblProductQuantity.text = String("Quantity - \(outverdproduct.inproductQuantity) items")
      //  let outverdproduct : Inverd = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! Inverd
        outwardCellObj.inProductRate.text = String(outverdproduct.inproductCurrentRate)
        outwardCellObj.inProductquantity.text = String(outverdproduct.inproductQuantity)
        outwardCellObj.inProductImage.setRound()
        arrproductInfo = ModelManager.getInstance().getSpecificProductData(ID: outverdproduct.productID)
        
        let productObj : ProductInfo = arrproductInfo.firstObject as! ProductInfo
        outwardCellObj.inProductName.text = productObj.productName
        outwardCellObj.inProductDesc.text = productObj.productDescription
        
        if productObj.productImage != "" {
            outwardCellObj.inProductImage.image = Utility.getImageFromBase64(base64: productObj.productImage)
        }else{
            outwardCellObj.inProductImage.image = UIImage.init(named: "asset-placeholder")
        }
        
        return outwardCellObj
    }
 /*   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }*/
 /*   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }*/
   /* func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "inverdheadercell")! as! inverdHeaderCell
        
        if (arrForSection[section] as! NSMutableArray).count > 0
        {
            let dict = ((arrForSection .object(at: section)) as! NSMutableArray).object(at: 0) as! Inverd
            
            sectionHeader.setData(title: dict.inproductDate)
                //  sectionHeader.setData(title: Utility.relativeDateStringForDate(strDate: Utility.stringToString(strDate: dict.inproductDate, fromFormat: DateFormat.DATE_MM_DD_YYYY, toFormat: DateFormat.DATE_FORMAT)) as String)
        }
        
        return sectionHeader
    }*/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
          //  let outproduct:Inverd = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! Inverd
            let outproduct:Inverd = arroutverdInfo.object(at: (arroutverdInfo.count - 1) - indexPath.row) as! Inverd
            
            let isDeleted = ModelManager.getInstance().deleteInwardData(inwardInfo: outproduct)
            if isDeleted {
                arrproductInfo = ModelManager.getInstance().getSpecificProductData(ID:outproduct.productID)
                let productObj : ProductInfo = arrproductInfo.firstObject as! ProductInfo
                
              productObj.productQuantity = Int(productObj.productQuantity + outproduct.inproductQuantity)
                
                productObj.productTotal = Double(productObj.productTotal + outproduct.inproductTotal)
             //   productObj.productCurrentRate = inverdRateCalucationDeletion(inverdProductTotal:productObj.productTotal , inverdProductQuantity: productObj.productQuantity)
                
                let isUpdated = ModelManager.getInstance().updateProductData(productInfo: productObj)
                if isUpdated {
                    // Utility.showToast(message: "Record Inserted successfully.")
                    //  self.navigationController?.popViewController(animated: true)
                } else {
                    Utility.showToast(message: "Error in inserting outward.")
                }
                
                Utility.showToast(message: "outward deleted successfully.")
            } else {
                Utility.showToast(message: "Error in deleting outward.")
            }
            self.getProductData()
        }

    }
    func inverdRateCalucationDeletion(inverdProductTotal:Double,inverdProductQuantity:Int)->Double{
        return (inverdProductTotal / Double(inverdProductQuantity))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let inOutvcObj : InOutVC = self.storyboard?.instantiateViewController(withIdentifier: "InOutvc") as! InOutVC
        inOutvcObj.inverdData = arroutverdInfo.object(at: (arroutverdInfo.count - 1) - indexPath.row) as! Inverd//((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! Inverd//
        inOutvcObj.isEdit = true
        inOutvcObj.isInverd = false
        self.navigationController?.pushViewController(inOutvcObj, animated: true)
        
    }
    @IBAction func onClickBtnOnward(_ sender: Any) {
        let inOutvcObj : InOutVC = self.storyboard?.instantiateViewController(withIdentifier: "InOutvc") as! InOutVC
        inOutvcObj.isEdit = false
        inOutvcObj.isInverd = false
        self.navigationController?.pushViewController(inOutvcObj, animated: true)
    }

    
    
    
    
    //MARK: Create for section
    func createSection()
    {
        arrForSection.removeAllObjects()
        let arrtemp = NSMutableArray()
        arrtemp.addObjects(from: (self.arroutverdInfo as NSArray) as! [Any])
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
                arrForSection.add(arr1)
            }
            
        }
        self.tableview.reloadData()
    }
}

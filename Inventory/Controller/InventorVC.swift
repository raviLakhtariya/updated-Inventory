//
//  InventorVC.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class InventorVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var addInventorBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var arrProductInfo : NSMutableArray!
    var transactionInfo : NSMutableArray!
    var count : Int = 0
    var arrForSection = NSMutableArray()
    var arrForCreateAt = NSMutableArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }

    func getProductData()
    {
        arrProductInfo = NSMutableArray()
        transactionInfo = NSMutableArray()
        
        arrProductInfo = ModelManager.getInstance().getAllProductData()
        transactionInfo = ModelManager.getInstance().getAllInwardData()
        //createSection()
        tableview.reloadData()
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialSetup()
    }
    func initialSetup(){
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 44/255.0, green: 80/255.0, blue: 137/255.0, alpha: 1.0)
        
        self.addInventorBtn.clipsToBounds = true
        self.addInventorBtn.layer.cornerRadius = self.addInventorBtn.frame.height / 2.0
        self.addInventorBtn.setShadow()
        getProductData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        if arrForSection.count > 0 {
//            return self.arrForSection.count
//
//        }else{
//            Utility.showToast(message: "No product found", backgroundColor: UIColor.black, textColor: UIColor.white)
//            return 0
//        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if arrProductInfo == nil {
            return 0
        }else {
            return arrProductInfo.count
        }
      //  return (((arrForSection .object(at: section)) as! NSMutableArray).count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inventorCellObj : inventorscell = tableView.dequeueReusableCell(withIdentifier: "inventorscell") as! inventorscell
      let product:ProductInfo = arrProductInfo.object(at: (arrProductInfo.count - 1) - indexPath.row) as! ProductInfo
        
        // let product:ProductInfo = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! ProductInfo
        inventorCellObj.productName.text = product.productName
        inventorCellObj.productDec.text = product.productDescription
        inventorCellObj.productQuantity.text = String(product.productQuantity)
        inventorCellObj.productRate.text = String(product.productCurrentRate)
        
        inventorCellObj.lblProductQuantity.text = String("Quantity - \(product.productQuantity) items")
        inventorCellObj.lblProductRate.text = String("Current rate - \(product.productCurrentRate)")
        inventorCellObj.productImg.setRound()
        if product.productImage != "" {
            inventorCellObj.productImg.image = Utility.getImageFromBase64(base64: product.productImage)
        }else{
            inventorCellObj.productImg.image = UIImage.init(named: "asset-placeholder")
        }
    return inventorCellObj
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createInventorObj : createInventoryVC = self.storyboard?.instantiateViewController(withIdentifier: "createInventoryvc") as! createInventoryVC
        createInventorObj.isEdit = true
         createInventorObj.productData = arrProductInfo.object(at: (arrProductInfo.count - 1) - indexPath.row) as! ProductInfo
      //  createInventorObj.productData = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! ProductInfo
        self.navigationController?.pushViewController(createInventorObj, animated: true)
    }
    
  /*  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }*/
 /*   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }*/
 /*   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
            let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "inverdheadercell")! as! inverdHeaderCell
        print(arrForSection.count)
        if (arrForSection[section] as! NSMutableArray).count > 0
        {
            let dict = ((arrForSection .object(at: section)) as! NSMutableArray).object(at: 0) as! ProductInfo
            
            sectionHeader.setData(title: dict.productDate)
            var aray : [ProductInfo] = []
            for i in 0..<arrForSection.count {
                var dicts = (arrForSection[i] as! NSMutableArray).object(at: 0) as! ProductInfo
                
            aray.append(dicts)
             
            }
            print(aray)
            print(aray.count)
         var readys  =  aray.sorted(by: { $0.productDate > $1.productDate })
            print(readys)
            print(readys.count)
            sectionHeader.setData(title: readys[section].productDate)
  
        }
        
        return sectionHeader
    }*/
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
       //     let product:ProductInfo = ((arrForSection .object(at: indexPath.section)) as! NSMutableArray).object(at: indexPath.row) as! ProductInfo
            let product:ProductInfo = arrProductInfo.object(at: (arrProductInfo.count - 1) - indexPath.row) as! ProductInfo
            
            
            for i in 0..<transactionInfo.count {
                   let inverdoutverDataobj : Inverd = transactionInfo[i] as! Inverd
                if product.productID == inverdoutverDataobj.productID {
                    Utility.showToast(message: "Error in deleting product.")
                    count = count + 1
                }else{
                    
                }
            }
            if count == 0 {
                let isDeleted = ModelManager.getInstance().deleteProductData(productInfo: product)
                if isDeleted {
                    Utility.showToast(message: "Product deleted successfully.")
                } else {
                    Utility.showToast(message: "Error in deleting product.")
                }
                self.getProductData()
            }else{
                
            }
           
          
           
        }
    }

    @IBAction func onClickAddInventor(_ sender: Any) {
        let createInventorObj : createInventoryVC = self.storyboard?.instantiateViewController(withIdentifier: "createInventoryvc") as! createInventoryVC
        createInventorObj.isEdit = false
        self.navigationController?.pushViewController(createInventorObj, animated: true)
    }
    
    
    //MARK: Create for section
    func createSection()
    {
        arrForSection.removeAllObjects()
        let arrtemp = NSMutableArray()
        arrtemp.addObjects(from: (self.arrProductInfo as NSArray) as! [Any])
        for i in 0 ..< arrtemp.count
        {
            let dict:ProductInfo = arrtemp .object(at: i) as! ProductInfo
            let strDate:String = dict.productDate
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
                let dict:ProductInfo = arrtemp .object(at: i) as! ProductInfo
                let strDate:String = dict.productDate
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
    
    func currentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.WEB//"yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    func GetOnlyDateMonthYearFromFullDate(currentDateFormate:NSString , conVertFormate:NSString , convertDate:NSString ) -> NSString
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentDateFormate as String
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.WEB
        let finalDate = formatter.date(from: convertDate as String)
        formatter.dateFormat = conVertFormate as String
        print(finalDate!)
        let dateString = formatter.string(from: finalDate!)
        return dateString as NSString
    }

}

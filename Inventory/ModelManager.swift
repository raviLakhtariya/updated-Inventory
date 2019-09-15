//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil

    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath(fileName: "Inventory.db"))
        }
        return sharedInstance
    }
    
    
//    productID
//    productName
//    productQuantity
//    productCurrentRate
//    productDescription
//    productionTotal
//    productImage
//    productDate
//
//    Inverd
//    inID
//    productID
//    isInverd
//    inProductQuantity
//    inproductCurrentRate
//    inproductTotal
//    inProductDate


    func addProductData(productInfo : ProductInfo) -> Bool{
        sharedInstance.database?.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO Products (productName, productDescription, productQuantity, productCurrentRate, productTotal, productDate, productImage) VALUES (?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [/*productInfo.productID,*/productInfo.productName,productInfo.productDescription,productInfo.productQuantity,productInfo.productCurrentRate,productInfo.productTotal,productInfo.productDate,productInfo.productImage])

        sharedInstance.database!.close()
        return isInserted
    }


    func updateProductData(productInfo : ProductInfo) -> Bool{
        sharedInstance.database?.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE Products SET productName=?, productDescription=?, productQuantity=?, productCurrentRate=?, productTotal=?, productDate=?, productImage=? WHERE productID=?", withArgumentsIn: [productInfo.productName,productInfo.productDescription,productInfo.productQuantity,productInfo.productCurrentRate,productInfo.productTotal,productInfo.productDate,productInfo.productImage,productInfo.productID])
        sharedInstance.database!.close()
        return isUpdated
    }
    func deleteProductData(productInfo : ProductInfo) -> Bool{
        sharedInstance.database?.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM Products WHERE productID=?", withArgumentsIn:[productInfo.productID])
       //let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM Products", withParameterDictionary: nil)
        sharedInstance.database!.close()
        return isDeleted
    }

    func getSpecifiProductData(productInfo : ProductInfo)->NSMutableArray {
        sharedInstance.database!.open()
        let resultSet : FMResultSet! =  sharedInstance.database!.executeQuery("SELECT * FROM Products WHERE productID=?", withArgumentsIn: [productInfo.productID])
        let arrProductInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let productInfo : ProductInfo = ProductInfo()
                productInfo.productID = Int(resultSet.int(forColumn: "productID"))
                productInfo.productName = resultSet.string(forColumn: "productName")
                productInfo.productDescription = resultSet.string(forColumn: "productDescription")
                productInfo.productQuantity = Int(resultSet.int(forColumn: "productQuantity"))
                productInfo.productCurrentRate = resultSet.double(forColumn: "productCurrentRate")
                productInfo.productDate = resultSet.string(forColumn: "productDate")
                productInfo.productTotal = resultSet.double(forColumn: "productTotal")
                productInfo.productImage = resultSet.string(forColumn: "productImage")
                arrProductInfo.add(productInfo)
            }
        }
        sharedInstance.database!.close()
        return arrProductInfo
        
    }
 func getAllProductData()-> NSMutableArray {
    
        sharedInstance.database!.open()
    
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Products", withArgumentsIn: nil)
    
        let arrProductInfo : NSMutableArray = NSMutableArray()
    
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let productInfo : ProductInfo = ProductInfo()
                productInfo.productID = Int(resultSet.int(forColumn: "productID"))
                productInfo.productName = resultSet.string(forColumn: "productName")
                productInfo.productDescription = resultSet.string(forColumn: "productDescription")
                productInfo.productQuantity = Int(resultSet.int(forColumn: "productQuantity"))
                productInfo.productCurrentRate = resultSet.double(forColumn: "productCurrentRate")
                productInfo.productDate = resultSet.string(forColumn: "productDate")
                productInfo.productTotal = resultSet.double(forColumn: "productTotal")
                productInfo.productImage = resultSet.string(forColumn: "productImage")
                arrProductInfo.add(productInfo)
                
            }
        }
        sharedInstance.database!.close()
        return arrProductInfo
        
    }
    
    

    
    func addInwardData(inwardInfo : Inverd) -> Bool{
        sharedInstance.database?.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO Inverd (productID, inproductQuantity, inproductCurrentRate, inproductTotal, inproductDate, isinverd) VALUES ( ?, ?, ?, ?, ?, ?)", withArgumentsIn: [inwardInfo.productID,inwardInfo.inproductQuantity,inwardInfo.inproductCurrentRate,inwardInfo.inproductTotal,inwardInfo.inproductDate,inwardInfo.isinverd])
        
        sharedInstance.database!.close()
        return isInserted
    }
    
    
    func updateInwardData(inwardInfo : Inverd) -> Bool{
        sharedInstance.database?.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE Inverd SET productID=?, inproductQuantity=?, inproductCurrentRate=?, inproductTotal=?, inproductDate=?,isinverd = ?  WHERE inID=?", withArgumentsIn: [inwardInfo.productID,inwardInfo.inproductQuantity,inwardInfo.inproductCurrentRate,inwardInfo.inproductTotal,inwardInfo.inproductDate,inwardInfo.isinverd,inwardInfo.inID])
        sharedInstance.database!.close()
        return isUpdated
    }
    func deleteInwardData(inwardInfo : Inverd) -> Bool{
        sharedInstance.database?.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM Inverd WHERE inID=?", withArgumentsIn: [inwardInfo.inID])
        sharedInstance.database!.close()
        return isDeleted
    }
    func getInverdspecificData() ->NSMutableArray{
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Inverd WHERE isinverd=?", withArgumentsIn: [true])
        
        let arrInverdInfo : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let inverdInfo : Inverd = Inverd()
             //   if resultSet.bool(forColumn: "isinverd") == true {
                    inverdInfo.inID = Int(resultSet.int(forColumn: "inID"))
                    inverdInfo.productID = Int(resultSet.string(forColumn: "productID"))!
                    inverdInfo.isinverd = resultSet.bool(forColumn: "isinverd")
                    inverdInfo.inproductCurrentRate = resultSet.double(forColumn: "inproductCurrentRate")
                    inverdInfo.inproductQuantity = Int(resultSet.int(forColumn: "inproductQuantity"))
                    inverdInfo.inproductTotal = resultSet.double(forColumn: "inproductTotal")
                    inverdInfo.inproductDate = resultSet.string(forColumn: "inproductDate")
                    arrInverdInfo.add(inverdInfo)
                
              //  }
                
            }
        }
        sharedInstance.database!.close()
        return arrInverdInfo
        
    }
    
    func getOutverdSpecificData()->NSMutableArray{
        sharedInstance.database!.open()
        
       let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Inverd WHERE isinverd=?", withArgumentsIn: [false])
        
        let arrOutverdInfo : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let outverdInfo : Inverd = Inverd()
              //  if resultSet.bool(forColumn: "isinverd") == false {
                    outverdInfo.inID = Int(resultSet.int(forColumn: "inID"))
                    outverdInfo.productID = Int(resultSet.string(forColumn: "productID"))!
                    outverdInfo.isinverd = resultSet.bool(forColumn: "isinverd")
                    outverdInfo.inproductCurrentRate = resultSet.double(forColumn: "inproductCurrentRate")
                    outverdInfo.inproductQuantity = Int(resultSet.int(forColumn: "inproductQuantity"))
                    outverdInfo.inproductTotal = resultSet.double(forColumn: "inproductTotal")
                    outverdInfo.inproductDate = resultSet.string(forColumn: "inproductDate")
                    arrOutverdInfo.add(outverdInfo)
                
     //           }
                
            }
        }
        sharedInstance.database!.close()
        return arrOutverdInfo
        
    }
    
    func getAllInwardData()-> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Inverd", withArgumentsIn: nil)
        
        let arrProductInfo : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let inverdInfo : Inverd = Inverd()
                inverdInfo.inID = Int(resultSet.int(forColumn: "inID"))
                inverdInfo.productID = Int(resultSet.string(forColumn: "productID"))!
                inverdInfo.isinverd = resultSet.bool(forColumn: "isinverd")
                inverdInfo.inproductCurrentRate = resultSet.double(forColumn: "inproductCurrentRate")
                inverdInfo.inproductQuantity = Int(resultSet.int(forColumn: "inproductQuantity"))
                inverdInfo.inproductTotal = resultSet.double(forColumn: "inproductTotal")
                inverdInfo.inproductDate = resultSet.string(forColumn: "inproductDate")
                arrProductInfo.add(inverdInfo)
                
            }
        }
        sharedInstance.database!.close()
        return arrProductInfo
        
    }
    func getSpecificInverdData(ID:Int)-> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Inverd WHERE productID = ?", withArgumentsIn: [ID])
        
        let arrProductInfo : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let inverdInfo : Inverd = Inverd()
                inverdInfo.inID = Int(resultSet.int(forColumn: "inID"))
                inverdInfo.productID = Int(resultSet.string(forColumn: "productID"))!
                inverdInfo.isinverd = resultSet.bool(forColumn: "isinverd")
                inverdInfo.inproductCurrentRate = resultSet.double(forColumn: "inproductCurrentRate")
                inverdInfo.inproductQuantity = Int(resultSet.int(forColumn: "inproductQuantity"))
                inverdInfo.inproductTotal = resultSet.double(forColumn: "inproductTotal")
                inverdInfo.inproductDate = resultSet.string(forColumn: "inproductDate")
                arrProductInfo.add(inverdInfo)
                
            }
        }
        sharedInstance.database!.close()
        return arrProductInfo
        
    }
    func getSpecificProductData(ID:Int)-> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Products WHERE productID = ?", withArgumentsIn: [ID])
        
        let arrProductInfo : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let productInfo : ProductInfo = ProductInfo()
                productInfo.productID = Int(resultSet.int(forColumn: "productID"))
                productInfo.productName = resultSet.string(forColumn: "productName")
                productInfo.productDescription = resultSet.string(forColumn: "productDescription")
                productInfo.productQuantity = Int(resultSet.int(forColumn: "productQuantity"))
                productInfo.productCurrentRate = resultSet.double(forColumn: "productCurrentRate")
                productInfo.productDate = resultSet.string(forColumn: "productDate")
                productInfo.productTotal = resultSet.double(forColumn: "productTotal")
                productInfo.productImage = resultSet.string(forColumn: "productImage")
                arrProductInfo.add(productInfo)
                
            }
        }
        sharedInstance.database!.close()
        return arrProductInfo
        
    }
    func getSpecificInverdDataWithDate(ID:Int,date:String)-> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM Inverd WHERE productID = ? AND inproductDate = ?", withArgumentsIn: [ID,date])
        
        let arrProductInfo : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                let inverdInfo : Inverd = Inverd()
                inverdInfo.inID = Int(resultSet.int(forColumn: "inID"))
                inverdInfo.productID = Int(resultSet.string(forColumn: "productID"))!
                inverdInfo.isinverd = resultSet.bool(forColumn: "isinverd")
                inverdInfo.inproductCurrentRate = resultSet.double(forColumn: "inproductCurrentRate")
                inverdInfo.inproductQuantity = Int(resultSet.int(forColumn: "inproductQuantity"))
                inverdInfo.inproductTotal = resultSet.double(forColumn: "inproductTotal")
                inverdInfo.inproductDate = resultSet.string(forColumn: "inproductDate")
                arrProductInfo.add(inverdInfo)
                
            }
        }
        sharedInstance.database!.close()
        return arrProductInfo
        
    }
 /*
     Dashboard or chart table
     add tabbar controller
     search view controller
     filter
     
     */
    
    
    
    
    
    
    
}

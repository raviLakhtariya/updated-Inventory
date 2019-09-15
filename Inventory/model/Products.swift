//
//  Products.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import Foundation

struct Products : Codable
{
    
        var productID : Int?
        var productName : String?
        let productQuantity : Int?
        var productCurrentRate : Double?
        let productDescription : String?
        let productTotal : Double?
        let productImage : String?
        let productDate : String?
    
    
        
        enum CodingKeys: String, CodingKey {
            
            case productID = "productID"
            case productName = "productName"
            case productQuantity = "productQuantity"
            case productCurrentRate = "productCurrentRate"
            case productDescription = "productDescription"
            case productTotal = "productTotal"
            case productImage = "productImage"
            case productDate = "productDate"
      
           
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            productID = try values.decodeIfPresent(Int.self, forKey: .productID)
            productName = try values.decodeIfPresent(String.self, forKey: .productName)
            productQuantity = try values.decodeIfPresent(Int.self, forKey: .productQuantity)
            productCurrentRate = try values.decodeIfPresent(Double.self, forKey: .productCurrentRate)
            productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
            productTotal = try values.decodeIfPresent(Double.self, forKey: .productTotal)
            productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
            productDate = try values.decodeIfPresent(String.self, forKey: .productDate)
         
          
        }
        
    
    
}

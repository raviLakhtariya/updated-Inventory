//
//  DBManager.swift
//  FMDBTut
//
//  Created by Gabriel Theodoropoulos on 07/10/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class DBManager: NSObject {

//    let field_MovieID = "movieID"
//    let field_MovieTitle = "title"
//    let field_MovieCategory = "category"
//    let field_MovieYear = "year"
//    let field_MovieURL = "movieURL"
//    let field_MovieCoverURL = "coverURL"
//    let field_MovieWatched = "watched"
//    let field_MovieLikes = "likes"
    
    let field_ProductID = "productID"
    let field_ProductName = "productName"
    let field_ProductQuantity = "productQuantity"
    let field_ProductCurrentRate = "productCurrentRate"
    let field_ProductDate = "productDate"
    let field_productImage = "productImage"
    let field_productDescription = "productDescription"
    let field_productTotal = "productTotal"
    
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "Inventory.db"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createProductTableQuery = "create table product_info (\(field_ProductID) integer primary key autoincrement not null, \(field_ProductName) text not null, \(field_productDescription) text not null, \(field_ProductQuantity) integer not null, \(field_productTotal) integer not null, \(field_ProductCurrentRate) integer not null, \(field_productImage) String, \(field_ProductDate) REAL)"
                    
                    do {
                        try database.executeUpdate(createProductTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    
 /*   func insertMovieData() {
        if openDatabase() {
            if let pathToMoviesFile = Bundle.main.path(forResource: "movies", ofType: "tsv") {
                do {
                    let moviesFileContents = try String(contentsOfFile: pathToMoviesFile)
                    
                    let moviesData = moviesFileContents.components(separatedBy: "\r\n")
                    
                    var query = ""
                    for movie in moviesData {
                        let movieParts = movie.components(separatedBy: "\t")
                        
                        if movieParts.count == 5 {
                            let movieTitle = movieParts[0]
                            let movieCategory = movieParts[1]
                            let movieYear = movieParts[2]
                            let movieURL = movieParts[3]
                            let movieCoverURL = movieParts[4]
                            
                            query += "insert into Products (\(field_ProductID), \(field_ProductName), \(field_productDescription), \(field_ProductQuantity), \(field_ProductCurrentRate), \(field_productTotal), \(field_ProductDate), \(field_productImage)) values (null, '\(movieTitle)', '\(movieCategory)', \(movieYear), '\(movieURL)', '\(movieCoverURL)', 0, 0);"
                        }
                    }
                    
                    if !database.executeStatements(query) {
                        print("Failed to insert initial data into the database.")
                        print(database.lastError(), database.lastErrorMessage())
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            database.close()
        }
    }
    */
/*
    func loadProducts() -> [Products]! {
        var products: [Products]!
        
        if openDatabase() {
            let query = "select * from Products order by \(field_ProductID) asc"
            
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
//                     productID
//                    productName
//                     productQuantity
//                     productCurrentRate
//                     productDescription
//                        productTotal
//                     productImage
//                     productDate
                    let product = Products(productID: Int(results.int(forColumn: field_ProductID)),
                                          productName:results.string(forColumn: field_ProductName),
                                          productDescription: results.string(forColumn: field_productDescription),
                                          productQuantity: Int(results.int(forColumn: field_ProductQuantity)),
                                          productCurrentRate : Double(results.string(forColumn: field_ProductCurrentRate)),
                                          productTotal: Double(results.string(forColumn: field_productTotal)),
                                          productDate: results.date(forColumn: field_ProductDate),
                                          productImage: results.int(forColumn: field_productImage)
                    )
                    
                    if products == nil {
                        products = [Products]
                    }
                    
                    products.append(product)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return products
    }
    */
   /*
    func loadMovie(withID ID: Int, completionHandler: (_ productInfo: Products?) -> Void) {
        var productInfo: Products!
        
        if openDatabase() {
            let query = "select * from movies where \(field_ProductID)=?"
            
            do {
                let results = try database.executeQuery(query, values: [ID])
                
                if results.next() {
                     productInfo = Products(productID: Int(results.int(forColumn: field_ProductID)),
                                           productName : results.string(forColumn: field_ProductName),
                                           productDescription : results.string(forColumn: field_productDescription),
                                           productQuantity : Int(results.int(forColumn: field_ProductQuantity)),
                                           productCurrentRate : Double(results.string(forColumn: field_ProductCurrentRate)),
                                           productTotal : Double(results.string(forColumn: field_productTotal)),
                                           productDate : results.date(forColumn: field_ProductDate),
                                           productImage : results.int(forColumn: field_productImage)

                    )
                    
                }
                else {
                    print(database.lastError())
                }
            }//35 + 9:07
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        completionHandler(productInfo)
    }
    
    */
 /*   func updateMovie(withID ID: Int, watched: Bool, likes: Int) {
        if openDatabase() {
            let query = "update Products set \(field_ProductName)=?, \(field_productTotal)=? where \(field_ProductID)=?"
            
            do {
                try database.executeUpdate(query, values: [watched, likes, ID])
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
    }
    
    
    func deleteMovie(withID ID: Int) -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = "delete from Products where \(field_ProductID)=?"
            
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }*/
    
}

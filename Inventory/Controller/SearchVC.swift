//
//  SearchVC.swift
//  Inventory
//
//  Created by Janki on 25/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tableview: UITableView!
    var arrProductInfo : NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       self.getProductData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrProductInfo.count == 0{
            return 0
        }else{
            return arrProductInfo.count

        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : searchCell = tableView.dequeueReusableCell(withIdentifier: "searchcell") as! searchCell
        let product:ProductInfo = arrProductInfo.object(at: indexPath.row) as! ProductInfo
        
        cell.lblProductName.text = product.productName
        cell.lblProductDescription.text = product.productDescription
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    
    func getProductData()
    {
        arrProductInfo = NSMutableArray()
        arrProductInfo = ModelManager.getInstance().getAllProductData()
        tableview.reloadData()
    }

}

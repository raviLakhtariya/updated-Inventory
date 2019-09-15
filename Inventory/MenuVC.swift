//
//  MenuVC.swift
//  Inventory
//
//  Created by Janki on 26/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class MenuVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var arrays: NSMutableArray = NSMutableArray.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellsObject : MenuCell = tableView.dequeueReusableCell(withIdentifier: "menucell") as! MenuCell
        
        return cellsObject
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  
}

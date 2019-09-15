//
//  inventorscell.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class inventorscell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDec: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productRate: UILabel!
    
    @IBOutlet weak var lblProductQuantity: UILabel!
    
    @IBOutlet weak var lblProductRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.clipsToBounds = true
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 10.0
        self.mainView.setShadow()
        self.productName.layer.cornerRadius = self.productImg.frame.height / 2.0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

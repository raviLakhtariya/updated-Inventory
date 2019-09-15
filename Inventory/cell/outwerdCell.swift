//
//  outwerdCell.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class outwerdCell: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var inProductImage: UIImageView!
    @IBOutlet weak var inProductName: UILabel!
    @IBOutlet weak var inProductDesc: UILabel!
    
    @IBOutlet weak var inProductRate: UILabel!
    @IBOutlet weak var inProductquantity: UILabel!
    
    @IBOutlet weak var lblProductRate: UILabel!
    
    @IBOutlet weak var lblProductQuantity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.clipsToBounds = true
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 10.0
        self.mainView.setShadow()
        self.inProductImage.layer.cornerRadius = self.inProductImage.frame.height / 2.0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

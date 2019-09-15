//
//  AllTransactionCell.swift
//  Inventory
//
//  Created by Janki on 29/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class AllTransactionCell: UITableViewCell {

    @IBOutlet weak var alltransactionView: UIView!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblProductQuantity: UILabel!
    @IBOutlet weak var lblProductRate: UILabel!
    @IBOutlet weak var inverdOroutverd: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

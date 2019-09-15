//
//  inverdHeaderCell.swift
//  Inventory
//
//  Created by PRASHANT MAHETA on 31/08/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit

class inverdHeaderCell: UITableViewCell {

    @IBOutlet weak var lblSection: UILabel!
  //  @IBOutlet weak var roundedView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(title: String)
        
    {
        
        lblSection.text =  title
      //  roundedView.sizeToFit()
       // roundedView.setRound(withBorderColor: .clear, andCornerRadious: (roundedView.frame.height/2), borderWidth: 0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

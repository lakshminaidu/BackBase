//
//  CityCell.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import UIKit

class CityCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var city: City? {
        didSet {
            self.nameLabel.text = city?.title
            self.locationLabel.text = city?.subTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

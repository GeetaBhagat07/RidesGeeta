//
//  VehicleListCell.swift
//  Rides
//
//  Created by ShanuGeet on 2023-01-30.
//

import UIKit

class VehicleListCell: UITableViewCell {

    @IBOutlet weak var lblMakeAndModel: UILabel?
    @IBOutlet weak var lblVin: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setVehiclesData:VehicleListBase?{
        didSet {
            lblMakeAndModel?.text = setVehiclesData?.make_and_model
            lblVin?.text = setVehiclesData?.vin
        }
    }
    
}

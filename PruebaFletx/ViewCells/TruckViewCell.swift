//
//  TruckViewCell.swift
//  PruebaFletx
//
//  Created by Julian González on 16/11/21.
//

import UIKit

class TruckViewCell: UITableViewCell {

    @IBOutlet weak var contentViewCell: UIView!
    
    @IBOutlet weak var truckImage: UIImageView!
    
    @IBOutlet weak var truckPlate: UILabel!
    @IBOutlet weak var truckName: UILabel!
    @IBOutlet weak var truckTrailer: UILabel!
    @IBOutlet weak var truckAvailable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentViewCell.layer.borderWidth = 0.2
        contentViewCell.layer.borderColor = UIColor.white.cgColor
        contentViewCell.layer.cornerRadius = 10
        truckImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataInit (image: String, plate: String, name:String, trailer: String, available: String) {
        if let data = NSData(contentsOf: URL(string: image)!) {
            truckImage.image = UIImage(data: data as Data)
        }
        truckPlate.text = plate
        truckName.text = name
        truckTrailer.text = trailer
        truckAvailable.text = available
    }
}

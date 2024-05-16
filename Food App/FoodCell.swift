//
//  FoodCell.swift
//  Food App
//
//  Created by Dhawal Mahajan on 16/05/24.
//

import UIKit

class FoodCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var foodCollection : UICollectionView!
    @IBOutlet weak var indicator: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

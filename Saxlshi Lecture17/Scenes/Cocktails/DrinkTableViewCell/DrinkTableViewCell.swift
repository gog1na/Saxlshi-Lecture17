//
//  DrinkTableViewCell.swift
//  Saxlshi Lecture17
//
//  Created by Giorgi Goginashvili on 1/10/23.
//

import UIKit
import Kingfisher

class DrinkTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var drinkName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    //MARK: - Methods
    func setupCellUI() {
        drinkImageView.layer.cornerRadius = drinkImageView.bounds.width / 2
    }
    
    func configure(with drink: Drink) {
        drinkImageView.kf.indicatorType = .activity
        drinkImageView.kf.setImage(with: URL(string: drink.image))
        drinkName.text = drink.name
    }
    
}

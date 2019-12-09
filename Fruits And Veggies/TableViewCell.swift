//
//  TableViewCell.swift
//  Fruits And Veggies
//
//  Created by Nick Haidari on 11/27/19.
//  Copyright © 2019 Nick Haidari. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet var starCollection: [UIImageView]!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func update(with foodData:  FoodData ) {
        guard let url = URL(string: foodData.foodImage) else { return }
        do {
            let data = try Data(contentsOf: url)
            foodImageView.image = UIImage(data: data)
        } catch {
            print("error")
        }
        foodNameLabel.text = foodData.foodName
        for star in starCollection {
            let image = UIImage(named: (star.tag < Int(foodData.starValue)! ? "food-star": "" ))
            star.image = image
        }
    
    }
    
    
}

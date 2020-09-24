//
//  RecipeCell.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet private weak var cardView: UIView!
    var recipe: RecipeEntity? {
        didSet {
            prepareForReuse()
        }
    }
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        recipeTitle.text = recipe?.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

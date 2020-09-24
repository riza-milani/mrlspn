//
//  RecipeCell.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit
import Kingfisher

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
        selectionStyle = .none
        recipeImage.layer.cornerRadius = recipeImage.frame.height / 2
    }

    override func prepareForReuse() {
        recipeTitle.text = recipe?.title
        if let imageString = recipe?.image, let imageUrl = URL(string: imageString) {
            recipeImage.kf.setImage(with: imageUrl)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

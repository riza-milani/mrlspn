//
//  RecipeDetailViewController.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class RecipeDetailViewController: UIViewController {

    var presenter: RecipeDetailPresenterProtocol?

    lazy private var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy private var recipeTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.numberOfLines = 0
        return title
    }()

    lazy private var recipeDescription: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }()

    lazy private var recipeChefName: UILabel = {
        let lable = UILabel()
        lable.textColor = .blue
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        return lable
    }()

    lazy private var recipeTags: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUIView()
        view.addSubview(recipeImageView)
        view.addSubview(recipeTitle)
        view.addSubview(recipeChefName)
        view.addSubview(recipeTags)
        view.addSubview(recipeDescription)
    }

    func initUIView() {

        let recipe = presenter?.getRecipe()

        if let imageString = recipe?.image, let imageUrl = URL(string: imageString) {
            recipeImageView.kf.setImage(with: imageUrl)
        }

        recipeTitle.text = recipe?.title

        recipeChefName.text = recipe?.chef

        recipeDescription.text = recipe?.description

        recipe?.tags?.forEach({ tag in
            let label = createTagLabelByString(tag)
            recipeTags.addArrangedSubview(label)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        recipeImageView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view.snp.topMargin)
            }
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 4)
        }

        recipeTitle.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.leading.equalTo(view.snp.leadingMargin)
        }

        recipeChefName.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.centerX).inset(32)
        }

        recipeTags.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(16)
            make.bottom.equalTo(recipeChefName)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.leading.equalTo(view.snp.centerX).inset(32)
        }

        recipeDescription.snp.makeConstraints { make in
            make.top.equalTo(recipeChefName.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension RecipeDetailViewController {

    func createTagLabelByString(_ text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.text = text
        label.textAlignment = .center
        return label
    }
}

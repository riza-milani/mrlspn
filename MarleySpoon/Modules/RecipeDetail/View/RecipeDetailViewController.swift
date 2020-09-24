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
        return imageView
    }()

    lazy private var recipeTitle: UILabel = {
        let title = UILabel()
        return title
    }()

    lazy private var recipeDescription: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.backgroundColor = .gray
        return textView
    }()

    lazy private var recipeChefName: UILabel = {
        let lable = UILabel()
        lable.text = "Chef"
        lable.backgroundColor = .gray
        return lable
    }()

    lazy private var recipeTags: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .gray
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
        recipeTitle.text = recipe?.title
        recipeChefName.text = recipe?.chef
        recipeDescription.text = recipe?.description
        if let imageString = recipe?.image, let imageUrl = URL(string: imageString) {
            recipeImageView.kf.setImage(with: imageUrl)
            recipeImageView.contentMode = .scaleAspectFit
        }
        recipe?.tags?.forEach({ tag in
            let view = UIView()
            view.layer.cornerRadius = 10
            view.backgroundColor = .gray
            let label = UILabel()
            label.text = tag
            label.textAlignment = .center
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.height.equalToSuperview()
            }
            recipeTags.addArrangedSubview(view)
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
            make.trailing.leading.equalToSuperview().inset(16)
        }

        recipeChefName.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(view.snp.centerX).inset(32)
        }

        recipeTags.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(16)
            make.bottom.equalTo(recipeChefName)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(view.snp.centerX).inset(32)
        }

        recipeDescription.snp.makeConstraints { make in
            make.top.equalTo(recipeChefName.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

}

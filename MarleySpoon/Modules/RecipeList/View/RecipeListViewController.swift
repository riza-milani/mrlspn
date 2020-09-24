//
//  ViewController.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class RecipeListViewController: UIViewController {

    var presenter: RecipeListPresenterProtocol?
    let bag = DisposeBag()
    var recipes: [RecipeEntity]? {
        didSet {
            tableView.reloadData()
        }
    }

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: RecipeCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RecipeCell.self))
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        view.addSubview(tableView)
        subscribeToRecipes()
        presenter?.loadRecipes()
    }

    func subscribeToRecipes() {

        presenter?.recipeListState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoading(true)
                self.showNoRecipe(false)
            case .loaded:
                self.showLoading(false)
            case .empty:
                self.showLoading(false)
                self.showNoRecipe(true)
            case .error(let error):
                self.showLoading(false)
                self.showNoRecipe(true, message: error.localizedDescription)
            }
        }).disposed(by: bag)

        presenter?.recipes.subscribe(onNext: { [weak self] recipes in
            self?.recipes = recipes
        }).disposed(by: bag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    func showNoRecipe(_ state: Bool, message: String = "No recipes yet!\nCome back soon ...") {
        if state {
            let tableViewBackgroundView = UILabel()
            tableViewBackgroundView.text = message
            tableViewBackgroundView.numberOfLines = 0
            tableViewBackgroundView.font = UIFont.systemFont(ofSize: 20.0)
            tableViewBackgroundView.textAlignment = .center
            tableView.backgroundView = tableViewBackgroundView
        } else {
            tableView.backgroundView = nil
        }
    }

}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let recipe = recipes?[indexPath.row] {
            presenter?.showRecipeDetail(recipe)
        }
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipeCell.self), for: indexPath) as? RecipeCell else { return UITableViewCell() }
        cell.recipe = recipes?[indexPath.row]
        return cell
    }
}


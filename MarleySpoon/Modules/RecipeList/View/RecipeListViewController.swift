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
            showNoRecipe(recipes?.isEmpty ?? true)
            tableView.reloadData()
        }
    }

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: RecipeCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: RecipeCell.self))
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        showNoRecipe(true)
        subscribeToRecipes()
        presenter?.loadRecipes()
    }

    func subscribeToRecipes() {
        presenter?.recipes.subscribe(onNext: { [weak self] recipes in
            self?.recipes = recipes

        }, onError: { error in
            print("Error \(error)")
        }).disposed(by: bag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    func showNoRecipe(_ state: Bool) {
        if state {
            let tableViewBackgroundView = UILabel()
            tableViewBackgroundView.text = "No recipes yet!\nCome back soon ..."
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

//
//  CocktailsViewController.swift
//  Saxlshi Lecture17
//
//  Created by Giorgi Goginashvili on 1/9/23.
//

import UIKit

class CocktailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var drinksAPIManager: DrinksAPIManagerProtocol?
    var drinks: [Drink] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDrinks()
        setupTableView()
    }
    
    //MARK: - Actions
    @IBAction func didTapDrinkType(_ sender: UISegmentedControl) {
        guard let drinkType = DrinkType(rawValue: sender.selectedSegmentIndex) else { return }
        fetchDrinks(with: drinkType)
    }
    
    //MARK: - Methods
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DrinkTableViewCell", bundle: nil), forCellReuseIdentifier: "DrinkTableViewCell")
    }
    
    private func fetchDrinks(with type: DrinkType = .alcoholic) {
        drinksAPIManager = DrinksAPIManager()
        
        drinksAPIManager?.fetchDrinks(with: type, complition: { result in
            switch result {
            case .success(let drinkResponce):
                print(drinkResponce.drinks)
                self.drinks = drinkResponce.drinks
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

//MARK: - UITableViewDataSource
extension CocktailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkTableViewCell", for: indexPath) as! DrinkTableViewCell
        cell.configure(with: drinks[indexPath.row])
        return cell
    }
}

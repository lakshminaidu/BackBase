//
//  ViewController.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import UIKit

class CitiesController: BaseViewController {
    
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel: CitiesViewModelType!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        viewModel = CityViewModel()
        self.bindViewModel()
        self.viewModel.fetchCities()
    }
    
    func bindViewModel() {
        self.viewModel.cities?.bindAndFire({ _ in
            self.citiesTableView.reloadData()
        })
        self.viewModel.showLoader.bind() { show in
            self.showloader(state: show)
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MapViewController, let indexPath = citiesTableView.indexPathForSelectedRow {
            destinationViewController.viewModel = MapDetailViewModel(with: viewModel.city(at: indexPath.row))
        }
     
    }
    // Do any additional setup after loading the view.
}


// MARK: UITableViewDataSource
extension CitiesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cities?.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.name) as? CityCell {
            cell.city = viewModel.city(at: indexPath.row)
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
    }
    
}

// MARK: UITableViewDelegate
extension CitiesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UISearchBarDelegate

extension CitiesController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        viewModel?.searchCities(with: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel?.searchCities(with: self.searchBar.text ?? "")
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
}

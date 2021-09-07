//
//  SearchViewController.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import UIKit

class SearchViewController: UITableViewController {

    var searchViewModel: SearchViewModel!
    let searchView = SearchView()
        
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        self.view.addSubview(indicator)
        indicator.center = view.center
        return indicator
    }()
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.readSearchedCitiesFromUserDefaults()
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        addCallbacks()
    }
    
    fileprivate func addCallbacks() {
        searchView.onSearchPressed = { [weak self] city in
            self?.searchViewModel.fetchWeatherForCity(city: city)
        }
        searchViewModel.onActivityStarted = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
            }
        }
        searchViewModel.onActivityEnded = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        searchViewModel.onFetchFail = { [weak self] error in
            DispatchQueue.main.async {
                self?.showMessage(title: "Filed to fetch weather.", messagae: error)
            }
        }
        
    }

}


extension SearchViewController {
    //MARK: - Table callbacks
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                  for: indexPath)
         cell.textLabel?.text = self.searchViewModel.searchedCities[indexPath.row]
         cell.textLabel?.font = UIFont.systemFont(ofSize: 40)
         cell.textLabel?.textAlignment = .left
         return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.searchedCities.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewModel?.fetchWeatherForCity(city: searchViewModel.searchedCities[indexPath.row])
    }
    
}

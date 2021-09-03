//
//  SearchViewController.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import UIKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    var searchViewModel : SearchViewModel?
    
    override func loadView() {
        super.loadView()
        searchView.tableDelegate = self
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension SearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}

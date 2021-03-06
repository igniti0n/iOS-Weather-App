//
//  SearchView.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation
import UIKit
import SnapKit

class SearchView: UIView {
    var tableView = UITableView()
    var onSearchPressed: ((String) -> Void)?
    
    private lazy var backgroundImageView = UIImageView()
    private lazy var searchField = UITextField()
    private lazy var searchButton = UIButton()
    
    private let sidesInsets: CGFloat = 70
    
    private let normalFontSize: CGFloat = {
        UIScreen.main.bounds.height > 600 ? 30 : 20
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView(){
        let img = UIImage(named: "background")!
        backgroundImageView.image = img
        backgroundImageView.contentMode = .scaleAspectFill
        insertSubview(backgroundImageView, at: 0)
        searchField.placeholder = "Search"
        searchField.font = UIFont.systemFont(ofSize: normalFontSize)
        searchField.backgroundColor = .lightGray.withAlphaComponent(0.7)
        searchField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        searchField.layer.cornerRadius = 4
        searchField.layer.borderWidth = 1
        addSubview(searchField)
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        addSubview(searchButton)
        tableView.allowsSelection = true
        tableView.backgroundColor = UIColor.clear
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.separatorStyle = .none
        addSubview(tableView)
    }
    
    private func setUpConstraints(){
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        searchField.snp.makeConstraints { make in
            make.left.right.equalTo(safeAreaLayoutGuide).inset(sidesInsets)
            make.height.lessThanOrEqualTo(2*normalFontSize)
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
        }
        searchButton.snp.makeConstraints { make in
            make.left.equalTo(searchField.snp.right).offset(10)
            make.height.top.equalTo(searchField)
            make.width.equalTo(searchButton.snp.height)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(searchField)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchField.snp.bottom).offset(20)
        }
    }
    
}

fileprivate extension SearchView {
    //MARK: - Callbacks
    @objc func searchPressed(){
        guard let text = searchField.text else {return}
        onSearchPressed?(text)
    }
}

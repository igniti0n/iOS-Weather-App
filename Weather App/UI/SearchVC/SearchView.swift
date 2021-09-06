//
//  SearchView.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation
import UIKit
import SnapKit

class SearchView : UIView {
    var tableView = UITableView()
    var tableDelegate : UITableViewDelegate?
    var tableDataDelegate : UITableViewDataSource?
    var onSearchPressed: ((String)->Void)?
    
    private lazy var backgroundImageView = UIImageView()
    private lazy var searchField = UITextField()
    private lazy var searchButton = UIButton()
    
    private let normalFontSize : CGFloat = 30.0
    
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
        backgroundImageView.image = img.scalePreservingAspectRatio(targetSize: CGSize(width: UIScreen.main.bounds.width*8, height: UIScreen.main.bounds.height))
        backgroundImageView.contentMode = .scaleToFill
        insertSubview(backgroundImageView, at: 0)
        searchField.placeholder = "Search"
        searchField.font = UIFont.systemFont(ofSize: normalFontSize)
        searchField.bounds.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        //searchField.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
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
        }
        searchField.snp.makeConstraints { make in
            make.left.right.equalTo(safeAreaLayoutGuide).inset(80)
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
        }
        searchButton.snp.makeConstraints { make in
            make.left.equalTo(searchField.snp.right)
            make.top.bottom.equalTo(searchField)
            make.right.equalTo(safeAreaLayoutGuide)
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

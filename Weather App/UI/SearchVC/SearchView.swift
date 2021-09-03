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
    
    private lazy var backgroundImageView = UIImageView()
    
    private lazy var searchField = TextFieldPadding()
    private lazy var searchButton = UIButton()
    
    private lazy var tableView = UITableView()
    
    var tableDelegate : UITableViewDelegate?
    
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
        backgroundImageView.contentMode = .scaleToFill
        insertSubview(backgroundImageView, at: 0)
        
        searchField.placeholder = "Search"
        searchField.font = UIFont.systemFont(ofSize: normalFontSize)
        searchField.backgroundColor = .lightGray.withAlphaComponent(0.7)
        searchField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        searchField.layer.cornerRadius = 4
        searchField.layer.borderWidth = 1
        addSubview(searchField)
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        addSubview(searchButton)
        
        tableView.delegate = tableDelegate
        tableView.backgroundColor = nil
        tableView.separatorStyle = .none
        addSubview(tableView)
        
    }
    
    private func setUpConstraints(){
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchField.snp.makeConstraints { make in
            make.left.right.equalTo(safeAreaLayoutGuide).inset(80)
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
           // make.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints { make in
            make.left.equalTo(searchField.snp.right)
            make.top.bottom.equalTo(searchField)
            make.right.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(safeAreaLayoutGuide).inset(80)
            make.top.equalTo(searchField.snp.bottom)
        }
        
        
        
        
    }
    
}

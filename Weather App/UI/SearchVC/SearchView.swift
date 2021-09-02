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
    
    private lazy var searchField = UITextField()
    private lazy var searchButton = UIButton()
    
    private lazy var tabelView = UITableView()
    
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
        
        searchField.placeholder = "Search"
        addSubview(searchField)
        
    }
    
    private func setUpConstraints(){
        
        
        
    }
    
}

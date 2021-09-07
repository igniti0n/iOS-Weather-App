//
//  SearchTableViewCell.swift
//  Weather App
//
//  Created by Ivan Stajcer on 05.09.2021..
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setName(name: String){
        titleLabel.text = name
    }
    
    fileprivate func setUp(){
       setUpView()
       setUpConstraints()
    }
    
    fileprivate func setUpView(){
        backgroundColor = UIColor.clear
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        selectedBackgroundView?.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        selectedBackgroundView?.layer.cornerRadius = 10
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = UIColor.clear
        addSubview(titleLabel)
    }
    
    fileprivate func setUpConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

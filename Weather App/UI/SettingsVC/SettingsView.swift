//
//  SettingsView.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation
import UIKit
import SnapKit

class SettingsView : UIView {
    
    private lazy var backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    
    private lazy var topView = UIView()
    private lazy var bottomStackView = UIStackView()
    
    //top
    private lazy var celsiusCheckButton = UICheckBox( "isCelsius")
    private lazy var celsiusLabel = UILabel()
    
    private lazy var fahrenhitCheckButton =  UICheckBox("isFahrenhit")
    private lazy var fahrenheitLabel = UILabel()
    
    private lazy var celsiusStackView = UIStackView()
    private lazy var fahrenhitStackView = UIStackView()
    
    //bottom
    private lazy var humidity = UIImageView()
    private lazy var pressure = UIImageView()
    private lazy var wind = UIImageView()
    
    private lazy var humidityCheckButton = UICheckBox("showHumidity")
    private lazy var pressureCheckButton = UICheckBox("showPressure")
    private lazy var windCheckButton = UICheckBox("showWind")
    
    private lazy var humidityStackView = UIStackView()
    private lazy var pressureStackView = UIStackView()
    private lazy var windStackView = UIStackView()
    
    
   
    
    var celsiusButtonPressed : (()->Void)?
    var fahrenheitButtonPressed : (()->Void)?
    
    var humidityButtonPressed : (()->Void)?
    var pressureButtonPressed : (()->Void)?
    var windButtonPressed : (()->Void)?
    
    
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
        
        setUpTopStack()
        setUpBottomStack()
        
        topView.addSubview(celsiusStackView)
        topView.addSubview(fahrenhitStackView)
        
        bottomStackView.alignment = .center
        bottomStackView.distribution = .equalCentering
        bottomStackView.addArrangedSubview(humidityStackView)
        bottomStackView.addArrangedSubview(pressureStackView)
        bottomStackView.addArrangedSubview(windStackView)
        
        addSubview(topView)
        addSubview(bottomStackView)
        
    }
    
    private func setUpTopStack(){
                
        //CELS
        celsiusCheckButton.setOpposite(fahrenhitCheckButton)
        
        celsiusLabel.text = "Celsius"
        celsiusLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        celsiusLabel.textAlignment = .left
        
        celsiusStackView.alignment = .leading
        celsiusStackView.spacing = 20
        celsiusStackView.addArrangedSubview(celsiusCheckButton)
        celsiusStackView.addArrangedSubview(celsiusLabel)
        
        ///FAHR
        fahrenhitCheckButton.setOpposite(celsiusCheckButton)
        
        fahrenheitLabel.text = "Fahrenheit"
        fahrenheitLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        fahrenheitLabel.textAlignment = .left
        
        fahrenhitStackView.alignment = .leading
        fahrenhitStackView.spacing = 20
        fahrenhitStackView.addArrangedSubview(fahrenhitCheckButton)
        fahrenhitStackView.addArrangedSubview(fahrenheitLabel)
        
        
    }
    
    private func setUpBottomStack(){
        
        let imgPressed = UIImage(named: "check")!
        let hImage = UIImage(named: "humidity")!
        let pImage = UIImage(named: "pressure")!
        let wImage = UIImage(named: "wind")!
        
        
        humidity.image = hImage
        pressure.image = pImage
        wind.image = wImage
        
     
        
        humidityStackView.alignment = .center
        humidityStackView.spacing = 15
        humidityStackView.axis = .vertical
        humidityStackView.addArrangedSubview(humidity)
        humidityStackView.addArrangedSubview(humidityCheckButton)
        
        
        pressureStackView.alignment = .center
        pressureStackView.spacing = 15
        pressureStackView.axis = .vertical
        pressureStackView.addArrangedSubview(pressure)
        pressureStackView.addArrangedSubview(pressureCheckButton)
        
      
        
        windStackView.alignment = .center
        windStackView.axis = .vertical
        windStackView.spacing = 15
        windStackView.addArrangedSubview(wind)
        windStackView.addArrangedSubview(windCheckButton)
        
        
    }
    
    private func setUpConstraints(){
        
        celsiusCheckButton.snp.makeConstraints { make in
            make.width.equalTo(celsiusCheckButton.snp.height)
        }
        
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
        
        fahrenhitStackView.snp.makeConstraints { make in
            make.bottom.equalTo(topView).inset(80)
            make.left.equalTo(topView).inset(35)
        }
        
        celsiusStackView.snp.makeConstraints { make in
            make.left.equalTo(fahrenhitStackView)
            make.bottom.equalTo(fahrenhitStackView.snp.top).inset(-30)
        }
        
        //bottom
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalTo(safeAreaLayoutGuide).inset(60)
        }
        
        fahrenhitCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(celsiusCheckButton)
        }
        
        humidityCheckButton.snp.makeConstraints { make in
            make.height.width.equalTo(celsiusCheckButton)
        }
        
        pressureCheckButton.snp.makeConstraints { make in
            make.height.width.equalTo(celsiusCheckButton)
        }
        
        windCheckButton.snp.makeConstraints { make in
            make.height.width.equalTo(celsiusCheckButton)
        }
        
        wind.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        pressure.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        humidity.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
    }
    
}

extension SettingsView {
    
    @objc private func celsiusPressed(){
        print("H pressed!")
        celsiusButtonPressed?()
    }
    @objc private func fahrenheitPressed(){
        print("F pressed!")
        fahrenheitButtonPressed?()
    }
    @objc private func humidityPressed(){
        print("humi pressed!")
        humidityButtonPressed?()
    }
    @objc private func pressurePressed(){
        print("pres pressed!")
        pressureButtonPressed?()
    }
    @objc private func windPressed(){
        print("wind pressed!")
        windButtonPressed?()
    }
    
}


class CheckBox : UIView {
    
    let button = UIButton()
    
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
        
        
        
    }
    private func setUpConstraints(){
        
    }
    
}


import Foundation
import UIKit
import SnapKit

let normalFontSize : CGFloat = 30.0

class HomeView : UIView {
    /*
     Dijelim skrin na gornji i donji dio,
     u donjem dijelu koristim StackView za prikazivanje min i max temperature
     te jos jedan StackView za prikaz detalja(pressure,humidity,wind)
     
     Dodao sam callback za pritisak na 'search' i 'settings' buttone,
     čime HomeCoordinator zove start() metodu Search ili Settings kordinatora
     */
    
    private lazy var backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    
    private lazy var searchButton = UIButton()
    private lazy var settingsButton = UIButton()
    
    private lazy var weatherIcon = UIImageView()
    
    private lazy var temperatureLabel = UILabel()
    private lazy var cityNameLabel = UILabel()
    
    private lazy var bottomView = UIView()
    
    private lazy var minMaxStackView = UIStackView()
    private lazy var minTemperatureLabel = UILabel()
    private lazy var maxTemperatureLabel = UILabel()
    
    private lazy var detialsStackView = UIStackView()
    private lazy var humidityLabel = UILabel()
    private lazy var pressureLabel = UILabel()
    private lazy var windLabel = UILabel()
    
    
    var searchButtonPressed : (()->Void)?
    var settingsButtonPressed : (()->Void)?
    
    
    var conditionId = 802
    
    var iconName: String {
        switch conditionId {
            case 200...232:
            return "cloud.bolt" case 300...321:
            return "cloud.drizzle" case 500...531:
            return "cloud.rain" case 600...622:
            return "cloud.snow" case 701...781:
            return "cloud.fog" case 800:
            return "sun.max" case 801...804:
            return "cloud.bolt" default:
            return "cloud"
                
            }
    }
    
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
        
        weatherIcon.image = UIImage(systemName: iconName)
        weatherIcon.tintColor = UIColor(red: (30/255.0), green: (67/255.0), blue: (71/255.0), alpha: 1.0)
        addSubview(weatherIcon)
      
        searchButton.setImage(UIImage(named: "search")!, for: .normal)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        addSubview(searchButton)
        
        settingsButton.setImage(UIImage(named: "settings")!, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        addSubview(settingsButton)
        
        temperatureLabel.text = "21°C"
        temperatureLabel.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        temperatureLabel.contentMode = .scaleAspectFit
        addSubview(temperatureLabel)
        
        cityNameLabel.text = "London"
        cityNameLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        addSubview(cityNameLabel)
        
        setUpMinMaxStack()
        setUpDetailsStack()
        
        addSubview(bottomView)
       
        bottomView.addSubview(minMaxStackView)
        bottomView.addSubview(detialsStackView)
    }
    
    @objc private func searchTapped(){
        
        print("Search tapped!")
        searchButtonPressed?()
    }
    
    @objc private func settingsTapped(){
        
         print("Settings tapped!")
         settingsButtonPressed?()
    }
    
    private func setUpMinMaxStack(){
        
        minTemperatureLabel.text = "min \n 14.5°C"
        minTemperatureLabel.textAlignment = .center
        minTemperatureLabel.numberOfLines = 0
        minTemperatureLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        maxTemperatureLabel.numberOfLines = 0
        maxTemperatureLabel.text = "max \n 31.2°C"
        maxTemperatureLabel.textAlignment = .center
        maxTemperatureLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        
        minTemperatureLabel.sizeToFit()
        maxTemperatureLabel.sizeToFit()
        
        minMaxStackView.addArrangedSubview(minTemperatureLabel)
        minMaxStackView.addArrangedSubview(maxTemperatureLabel)
        minMaxStackView.alignment = .center
        minMaxStackView.distribution = .fillEqually
        
    }
    
    private func setUpDetailsStack(){
        
        let downAttributes :  [NSAttributedString.Key : Any] =
            [
                .font : UIFont.systemFont(ofSize: normalFontSize - 4, weight: .bold),
                .foregroundColor : UIColor.white
            ]
        
        let upAttributes :  [NSAttributedString.Key : Any]  =
            [
                .font : UIFont.systemFont(ofSize: normalFontSize - 8),
                .foregroundColor : UIColor.white
            ]
        
        let humidityAS =
            NSMutableAttributedString(string: "Humidity \n 0.79 %")
        humidityAS.addAttributes(upAttributes, range: NSRange(location: 0, length: 8))
        humidityAS.addAttributes(downAttributes,range: NSRange(location: 8,length: 9))
        humidityLabel.attributedText = humidityAS
        humidityLabel.numberOfLines = 2
        humidityLabel.textAlignment = .center
        humidityLabel.sizeToFit()
        
        let pressureAS =
            NSMutableAttributedString(string: "Pressure \n 1016.7 hpa")
        pressureAS.addAttributes(upAttributes, range: NSRange(location: 0, length: 8))
        pressureAS.addAttributes(downAttributes,range: NSRange(location: 8, length: 13))
        pressureLabel.attributedText = pressureAS
        pressureLabel.numberOfLines = 2
        pressureLabel.textAlignment = .center
        pressureLabel.sizeToFit()
        
        let windAS =
            NSMutableAttributedString(string:"Wind \n 4.34 mph")
        windAS.addAttributes(upAttributes, range: NSRange(location: 0, length: 4))
        windAS.addAttributes(downAttributes,range: NSRange(location: 5, length: 10))
        windLabel.attributedText = windAS
        windLabel.numberOfLines = 2
        windLabel.textAlignment = .center
        windLabel.sizeToFit()

        
        detialsStackView.addArrangedSubview(humidityLabel)
        detialsStackView.addArrangedSubview(pressureLabel)
        detialsStackView.addArrangedSubview(windLabel)
        detialsStackView.alignment = .bottom
        detialsStackView.distribution = .fillEqually
        
    }
    
    private func setUpConstraints(){
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.left.equalTo(safeAreaLayoutGuide).offset(40)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.width.height.equalTo(searchButton)
            make.left.equalTo(searchButton.snp.right).offset(20)
        }
        
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(60)
            make.trailing.equalToSuperview().inset(10)
            //make.height.equalTo(160)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(self).inset(40)
            make.right.equalTo(safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(temperatureLabel.snp.top).inset(-30)
            make.width.equalTo(weatherIcon.snp.height)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.trailing.equalTo(temperatureLabel)
        }
        
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(50)
        }
        
        
        minMaxStackView.snp.makeConstraints { make in
            make.left.right.top.equalTo(bottomView)
            make.height.equalTo(UIScreen.main.bounds.height * 0.24)
        }
        detialsStackView.snp.makeConstraints { make in
            make.top.equalTo(minMaxStackView.snp.bottom)
            make.bottom.equalTo(bottomView).inset(40)
            make.leading.trailing.equalTo(bottomView)
        }

    }
    
    
    
}



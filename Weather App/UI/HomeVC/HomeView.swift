
import Foundation
import UIKit
import SnapKit

class HomeView : UIView {
    /*
     Dijelim skrin na gornji i donji dio,
     u donjem dijelu koristim StackView za prikazivanje min i max temperature
     te jos jedan StackView za prikaz detalja(pressure,humidity,wind)
     
     Dodao sam callback za pritisak na 'search' i 'settings' buttone,
     čime HomeCoordinator zove start() metodu Search ili Settings kordinatora
     */
    var onSearchButtonPressed: EmptyCallback?
    var onSettingsButtonPressed: EmptyCallback?
    
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
    private var conditionId = 800
   
    private let normalFontSize: CGFloat = 30

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
        backgroundImageView.contentMode = .scaleAspectFill
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
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textAlignment = .right
        temperatureLabel.font = UIFont.systemFont(ofSize: normalFontSize*2.5, weight: .bold)
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
    
    private func setUpConstraints(){
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        searchButton.snp.makeConstraints { make in
           // make.width.height.equalTo(buttonSize)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.left.equalTo(safeAreaLayoutGuide).offset(40)
        }
        settingsButton.snp.makeConstraints { make in
            make.top.width.height.equalTo(searchButton)
            make.left.equalTo(searchButton.snp.right).offset(20)
        }
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(self).inset(40)
            make.right.equalTo(safeAreaLayoutGuide).inset(20)
            make.width.equalTo(UIScreen.main.bounds.width * 0.3)
            make.height.equalTo(weatherIcon.snp.width)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalToSuperview().inset(40)
        }
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(20)
            make.trailing.equalTo(temperatureLabel)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(0)
        }
        minMaxStackView.snp.makeConstraints { make in
            make.left.right.top.equalTo(bottomView)
        }
        detialsStackView.snp.makeConstraints { make in
            make.top.equalTo(minMaxStackView.snp.bottom)
            make.bottom.equalTo(bottomView).inset(40)
            make.leading.trailing.equalTo(bottomView)
        }
        humidityLabel.snp.makeConstraints { make in
            make.width.equalTo(pressureLabel)
        }
        windLabel.snp.makeConstraints { make in
            make.width.equalTo(pressureLabel)
        }

    }
        
    
}

extension HomeView {
    //MARK: - VIEW UPDATE
    func updateWeatherView(weather: Weather){
        let messurmentUnit = weather.temperature < 100 ? "°C" : "°F"
        temperatureLabel.text = "\(weather.temperature)\(messurmentUnit)"
        minTemperatureLabel.text = "min \n \(weather.minTemperature)\(messurmentUnit)"
        maxTemperatureLabel.text = "max \n \(weather.maxTemperature)\(messurmentUnit)"
        cityNameLabel.text = weather.name
        conditionId = weather.conditionId
        weatherIcon.image = UIImage(systemName: iconName)
        humidityLabel.attributedText = makeHumidityAttributedString(humidity: weather.humidity)
        pressureLabel.attributedText = makePressureAttributedString(pressure: weather.pressure)
        windLabel.attributedText = makeWindAttributedString(wind: weather.windSpeed)
    }
    
    func updateWeatherSettings(settings: Settings){
        let messurmentUnit = settings.isCelsius ? "°C" : "°F"
        temperatureLabel.text?.removeLast(2)
        temperatureLabel.text? += messurmentUnit
        minTemperatureLabel.text?.removeLast(2)
        minTemperatureLabel.text? += messurmentUnit
        maxTemperatureLabel.text?.removeLast(2)
        maxTemperatureLabel.text? += messurmentUnit
        humidityLabel.isHidden = !settings.showHumidity
        pressureLabel.isHidden = !settings.showPressure
        windLabel.isHidden = !settings.showWind
    }
}

fileprivate extension HomeView {
    //MARK: - View Setup
    func setUpMinMaxStack(){
        minTemperatureLabel.text = "min \n 14.5°C"
        minTemperatureLabel.textAlignment = .center
        minTemperatureLabel.numberOfLines = 0
        minTemperatureLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        minTemperatureLabel.sizeToFit()
        maxTemperatureLabel.numberOfLines = 0
        maxTemperatureLabel.text = "max \n 31.2°C"
        maxTemperatureLabel.textAlignment = .center
        maxTemperatureLabel.font = UIFont.systemFont(ofSize: normalFontSize)
        maxTemperatureLabel.sizeToFit()
        minMaxStackView.addArrangedSubview(minTemperatureLabel)
        minMaxStackView.addArrangedSubview(maxTemperatureLabel)
        minMaxStackView.alignment = .center
        minMaxStackView.distribution = .fillEqually
    }
    func setUpDetailsStack(){
        let humidityAS = makeHumidityAttributedString(humidity: 0.64)
        humidityLabel.attributedText = humidityAS
        humidityLabel.numberOfLines = 2
        humidityLabel.textAlignment = .center
        humidityLabel.adjustsFontSizeToFitWidth = true
        let pressureAS = makePressureAttributedString(pressure: 1062.4)
        pressureLabel.attributedText = pressureAS
        pressureLabel.numberOfLines = 2
        pressureLabel.textAlignment = .center
        pressureLabel.adjustsFontSizeToFitWidth = true
        let windAS = makeWindAttributedString(wind: 44)
        windLabel.attributedText = windAS
        windLabel.numberOfLines = 2
        windLabel.textAlignment = .center
        windLabel.adjustsFontSizeToFitWidth = true
        detialsStackView.addArrangedSubview(humidityLabel)
        detialsStackView.addArrangedSubview(pressureLabel)
        detialsStackView.addArrangedSubview(windLabel)
        detialsStackView.alignment = .bottom
        detialsStackView.distribution = .fillEqually

    }
    
}

fileprivate extension HomeView {
    //MARK: - Callbacks
    @objc func searchTapped(){
        onSearchButtonPressed?()
    }
    
    @objc func settingsTapped(){
         onSettingsButtonPressed?()
    }
}

fileprivate extension HomeView {
    //MARK: - Attributed Strings
     func makeHumidityAttributedString(humidity: Double) -> NSMutableAttributedString {
        let humidityAS = NSMutableAttributedString(string: "Humidity \n \(humidity) %")
        humidityAS.addAttributes(getAttributes(fontOffset: 8), range: NSRange(location: 0, length: 8))
        humidityAS.addAttributes(getAttributes(fontOffset: 4),range: NSRange(location: 8,length: humidityAS.string.count-8))
        return humidityAS
    }
    func makePressureAttributedString(pressure: Double) -> NSMutableAttributedString {
        let pressureAS = NSMutableAttributedString(string: "Pressure \n \(pressure) hpa")
        pressureAS.addAttributes(getAttributes(fontOffset: 8), range: NSRange(location: 0, length: 8))
        pressureAS.addAttributes(getAttributes(fontOffset: 4),range: NSRange(location: 8, length: pressureAS.string.count-8))
        return pressureAS
    }
    func makeWindAttributedString(wind: Double) -> NSMutableAttributedString {
        let windAS = NSMutableAttributedString(string:"Wind \n \(wind) mph")
        windAS.addAttributes(getAttributes(fontOffset: 8), range: NSRange(location: 0, length: 4))
        windAS.addAttributes(getAttributes(fontOffset: 4),range: NSRange(location: 5, length: windAS.string.count-5))
        return windAS
    }
    func getAttributes(fontOffset offset: CGFloat) -> [NSAttributedString.Key : Any] {
        let attributes :  [NSAttributedString.Key : Any]  =
           [
               .font : UIFont.systemFont(ofSize: normalFontSize - offset),
               .foregroundColor : UIColor.white
           ]
        return attributes
    }
}



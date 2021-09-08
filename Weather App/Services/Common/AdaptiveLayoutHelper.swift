//
//  AdaptiveLayoutHelper.swift
//  Weather App
//
//  Created by Ivan Stajcer on 08.09.2021..
//

import UIKit

import UIKit

enum Device {
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhone11Pro
    case iPhone11ProMax
    case iPhone12ProMax
    
    static let baseScreenSize: Device = .iPhone12ProMax
}

extension Device: RawRepresentable {
    typealias RawValue = CGSize
    
    init?(rawValue: CGSize) {
        switch rawValue {
        case CGSize(width: 320, height: 568):
            self = .iPhoneSE
        case CGSize(width: 375, height: 667):
            self = .iPhone8
        case CGSize(width: 414, height: 736):
            self = .iPhone8Plus
        case CGSize(width: 375, height: 812):
            self = .iPhone11Pro
        case CGSize(width: 414, height: 896):
            self = .iPhone11ProMax
        case CGSize(width: 428, height: 926):
            self = .iPhone12ProMax
        default:
            return nil
        }
        
        
    }
    
    var rawValue: CGSize {
        switch self {
        case .iPhoneSE:
            return CGSize(width: 320, height: 568)
        case .iPhone8:
            return CGSize(width: 375, height: 667)
        case .iPhone8Plus:
            return CGSize(width: 414, height: 736)
        case .iPhone11Pro:
            return CGSize(width: 375, height: 812)
        case .iPhone11ProMax:
            return CGSize(width: 414, height: 896)
        case .iPhone12ProMax:
            return CGSize(width: 428, height: 926)
        }
    }
}

enum Dimension {
    case height
    case width
}

var dimension: Dimension {
    UIDevice.current.orientation.isPortrait ? .width : .height
}

func resized(size: CGSize, basedOn dimension: Dimension) -> CGSize {
    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var ratio:  CGFloat = 0.0
    var width:  CGFloat = 0.0
    var height: CGFloat = 0.0
    
    switch dimension {
    case .width:
        ratio  = size.height / size.width
        width  = screenWidth * (size.width / Device.baseScreenSize.rawValue.width)
        height = width * ratio
    case .height:
        ratio  = size.width / size.height
        height = screenHeight * (size.height / Device.baseScreenSize.rawValue.height)
        width  = height * ratio
    }
    
    return CGSize(width: width, height: height)
}

func adapted(dimensionSize: CGFloat, to dimension: Dimension) -> CGFloat {
    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var ratio: CGFloat = 0.0
    var resultDimensionSize: CGFloat = 0.0
    
    switch dimension {
    case .width:
        ratio = dimensionSize / Device.baseScreenSize.rawValue.width
        resultDimensionSize = screenWidth * ratio
    case .height:
        ratio = dimensionSize / Device.baseScreenSize.rawValue.height
        resultDimensionSize = screenHeight * ratio
    }
    
    return resultDimensionSize
}


extension CGFloat {
    var adaptedFontSize: CGFloat {
        adapted(dimensionSize: self, to: dimension)
    }
}

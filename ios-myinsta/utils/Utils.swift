//
//  Utils.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 26/09/21.
//

import Foundation
import SwiftUI

class Utils{
    static var color1 = Color(red: 252/255, green: 175/255, blue: 69/255)
    static var color2 = Color(red: 245/255, green: 96/255, blue: 64/255)
    
    static var image1 = "https://lh6.googleusercontent.com/-9lzOk_OWZH0/URquoo4xYoI/AAAAAAAAAbs/AwgzHtNVCwU/s1024/Frantic.jpg"
    static var image2 = "https://lh4.googleusercontent.com/-JhFi4fb_Pqw/URquuX-QXbI/AAAAAAAAAbs/IXpYUxuweYM/s1024/Horseshoe%252520Bend.jpg"
    
    static func currentDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = df.string(from: date)
        return dateString
    }
}

extension UIScreen{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let size = UIScreen.main.bounds.size
}

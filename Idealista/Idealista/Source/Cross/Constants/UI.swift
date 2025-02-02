import UIKit

enum UI {
    enum Font {
        static let systemBold = "HelveticaNeue-Bold"
        static let systemRegular = "HelveticaNeue"
    }

    enum Color {
        static let greenery = UIColor(red: 136.0/255.0,
                                      green: 176.0/255.0,
                                      blue: 75.0/255.0,
                                      alpha: 1.0)
    }

    enum Image {
        static let heart = UIImage(named: "heart")
        static let heartFilled = UIImage(named: "heartFilled")
    }
}

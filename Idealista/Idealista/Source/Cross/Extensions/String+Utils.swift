import Foundation
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    func getAttributedPriceText() -> NSAttributedString {
        let priceText = NSMutableAttributedString(string: self)
        guard self.count > 1 else { return priceText }

        let currencyText = self.split(separator: " ").last ?? ""
        var currencyRange = (self as NSString).range(of: String(currencyText))
        currencyRange.location -= 1
        currencyRange.length += 1
        if let font = UIFont(name: UI.Font.systemBold, size: 14) {
            priceText.addAttribute(.font, value: font, range: currencyRange)
        }
        return priceText
    }

}

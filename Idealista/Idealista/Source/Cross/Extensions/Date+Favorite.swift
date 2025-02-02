import Foundation

extension Date {
    func createFavoriteText() -> String {
        String(format: String(localized: "favorite"),
               Formatter.formatDate(self))
    }
}

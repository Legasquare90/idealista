import Foundation

extension Date {
    func createFavoriteText() -> String {
        "Te gusta desde\n\(Formatter.formatDate(self))"
    }
}

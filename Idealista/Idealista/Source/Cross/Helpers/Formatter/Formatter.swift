import Foundation

final class Formatter {
    static func formatDoubleValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: value)) ?? String(format: "%.0f", value)
    }

    static func formatOrdinalNumber(_ number: String) -> String {
        guard let numberValue = Int(number) else {
            return number
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: numberValue)) ?? number
    }

    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
}

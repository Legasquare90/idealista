import Foundation

final class CacheManager {
    static let shared = CacheManager()

    private let cache = NSCache<NSString, CacheItem>()

    private let expirationTime: TimeInterval = 60 * 5

    private class CacheItem {
        let data: Data
        let timestamp: Date

        init(data: Data, timestamp: Date) {
            self.data = data
            self.timestamp = timestamp
        }
    }

    func save(_ data: Data, forKey key: String) {
        let cacheItem = CacheItem(data: data, timestamp: Date())
        cache.setObject(cacheItem, forKey: key as NSString)
    }

    func getData(forKey key: String) -> Data? {
        if let cacheItem = cache.object(forKey: key as NSString) {
            let elapsedTime = Date().timeIntervalSince(cacheItem.timestamp)
            if elapsedTime < expirationTime {
                return cacheItem.data
            } else {
                cache.removeObject(forKey: key as NSString)
            }
        }
        return nil
    }
}

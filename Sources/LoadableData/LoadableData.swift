import Foundation

public enum LoadableData<T> {
    case notAvailable
    case loading
    case failedToLoad(Error)
    case available(T)
    
    public var data: T? {
        guard case .available(let data) = self else {
            return nil
        }
        return data
    }
    
    public var error: Error? {
        guard case .failedToLoad(let error) = self else {
            return nil
        }
        return error
    }
    
    public var isLoading: Bool {
        guard case .loading = self else {
            return false
        }
        return true
    }
}

extension LoadableData: Equatable where T: Equatable {
    public static func == (lhs: LoadableData<T>, rhs: LoadableData<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notAvailable, .notAvailable): return true
        case (.loading, .loading): return true
        case (.failedToLoad(let lerr), .failedToLoad(let rerr)): return String(describing: lerr) == String(describing: rerr)
        case (.available(let ldata), .available(let rdata)): return ldata == rdata
        default: return false
        }
    }
}

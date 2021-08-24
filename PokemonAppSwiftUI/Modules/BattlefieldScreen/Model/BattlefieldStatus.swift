
import Foundation

enum BattlefieldStatus {
    case idle
    case loading
    case error(ErrorType)
    
}

extension BattlefieldStatus: Equatable {

    static func == (lhs: BattlefieldStatus, rhs: BattlefieldStatus) -> Bool {
        switch (lhs, rhs) {
        case (.error(_), .error(_)), (.idle, .idle), (.loading, .loading):
            return true
        default:
            return false
        }
    }
}

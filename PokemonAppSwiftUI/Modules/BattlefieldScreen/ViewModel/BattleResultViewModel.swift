
import SwiftUI

class BattleResultViewModel {
    
    var result: BattleResult?
    var onDismiss: ()->()
    
    init(_ result: BattleResult?, onDismiss: @escaping ()->()) {
        self.result = result
        self.onDismiss = onDismiss
    }
}

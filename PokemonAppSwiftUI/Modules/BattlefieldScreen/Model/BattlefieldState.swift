
import Foundation

struct BattlefieldState {
    var screenData: [RowItem<BattlefieldRowItemType, Any>] = .init()
    var selectedPokemon: Pokemon? = nil
    var selectedEnemyPokemon: Pokemon? = nil
    var battleResult: BattleResult? = nil
    var status: BattlefieldStatus = .idle
    
    func canFight() -> Bool {
        return  selectedPokemon != nil && selectedEnemyPokemon != nil
    }
    
}

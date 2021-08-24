
import Foundation

enum BattlefieldEvent {
    case onFinishedLoading([RowItem<BattlefieldRowItemType, Any>])
    case onAppear
    case onOccuredError(ErrorType)
    case onDismissError
    case onSelectPokemon(BattlefieldRowItemType, Pokemon?) // nillable due to select/unselect feature
    case onShowFightResults
    case onDismissFightResults
}


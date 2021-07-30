//
//  RowItem.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 30.07.2021..
//

import Foundation

struct RowItem<RowType, ValueType> : Identifiable {
    var id: UUID = .init()
    var type: RowType
    var value: ValueType
}

//
//  String+Extensions.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 30.07.2021..
//

import Foundation

extension String {
    private func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}


import Foundation

struct Pokemon: Codable, Identifiable {
    var id: Int
    var name: String
    var hp: Int
    var attack: Int
    var defense: Int
    var imagePath: String
    
    init(id: Int = -1, name: String = "unknown", hp: Int = -1, attack: Int = -1, defense: Int = -1, imageUrl: String = "") {
        self.id = id
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.imagePath = imageUrl
    }
}

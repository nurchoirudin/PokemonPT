//
//  PokemonDetailModel.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//
import Foundation
import UIKit

// MARK: - PokemonDetailModel
struct PokemonDetailModel: Codable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let heldItems: [HeldItem]?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let pastTypes: [PastType]?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case pastTypes = "past_types"
        case species, sprites, stats, types, weight
    }
    
    
    // MARK: - Ability
    struct Ability: Codable {
        let ability: Species?
        let isHidden: Bool?
        let slot: Int?
        
        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
    }
    
    // MARK: - Species
    struct Species: Codable {
        let name: String?
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case url = "url"
        }
        
        func getPokemonTypeImage() -> UIImage? {
            return UIImage(named: "ic_type_\(self.name?.uppercased() ?? "")")
        }
        
        func getPokemonTypeColor() -> UIColor? {
            switch self.name?.lowercased() {
            case "normal":
                return UIColor(hexString: "#9298A4")
            case "fire":
                return UIColor(hexString: "#FB9B51")
            case "water":
                return UIColor(hexString: "#4A90DD")
            case "grass":
                return UIColor(hexString: "#5FBC51")
            case "electric":
                return UIColor(hexString: "#EDD53E")
            case "ice":
                return UIColor(hexString: "#70CCBD")
            case "fighting":
                return UIColor(hexString: "#CE4265")
            case "poison":
                return UIColor(hexString: "#A864C7")
            case "ground":
                return UIColor(hexString: "#DC7545")
            case "flying":
                return UIColor(hexString: "#90A7DA")
            case "psychic":
                return UIColor(hexString: "#F66F71")
            case "bug":
                return UIColor(hexString: "#92BC2C")
            case "rock":
                return UIColor(hexString: "#C5B489")
            case "ghost":
                return UIColor(hexString: "#516AAC")
            case "dark":
                return UIColor(hexString: "#595761")
            case "dragon":
                return UIColor(hexString: "#0C69C8")
            case "steel":
                return UIColor(hexString: "#52869D")
            case "fairy":
                return UIColor(hexString: "#EC8CE5")
            default:
                return UIColor(hexString: "#FFFFFF")
            }
        }
    }
    
    // MARK: - GameIndex
    struct GameIndex: Codable {
        let gameIndex: Int?
        let version: Species?
        
        enum CodingKeys: String, CodingKey {
            case gameIndex = "game_index"
            case version
        }
    }
    
    // MARK: - Move
    struct Move: Codable {
        let move: Species?
        let versionGroupDetails: [VersionGroupDetail]?
        
        enum CodingKeys: String, CodingKey {
            case move
            case versionGroupDetails = "version_group_details"
        }
    }
    
    // MARK: - VersionGroupDetail
    struct VersionGroupDetail: Codable {
        let levelLearnedAt: Int?
        let moveLearnMethod, versionGroup: Species?
        
        enum CodingKeys: String, CodingKey {
            case levelLearnedAt = "level_learned_at"
            case moveLearnMethod = "move_learn_method"
            case versionGroup = "version_group"
        }
    }
    
    // MARK: - GenerationV
    struct GenerationV: Codable {
        let blackWhite: Sprites?
        
        enum CodingKeys: String, CodingKey {
            case blackWhite = "black-white"
        }
    }
    
    // MARK: - GenerationIv
    struct GenerationIv: Codable {
        let diamondPearl, heartgoldSoulsilver, platinum: Sprites?
        
        enum CodingKeys: String, CodingKey {
            case diamondPearl = "diamond-pearl"
            case heartgoldSoulsilver = "heartgold-soulsilver"
            case platinum
        }
    }
    
    // MARK: - Versions
    struct Versions: Codable {
        let generationI: GenerationI?
        let generationIi: GenerationIi?
        let generationIii: GenerationIii?
        let generationIv: GenerationIv?
        let generationV: GenerationV?
        let generationVi: [String: Home]?
        let generationVii: GenerationVii?
        let generationViii: GenerationViii?
        
        enum CodingKeys: String, CodingKey {
            case generationI = "generation-i"
            case generationIi = "generation-ii"
            case generationIii = "generation-iii"
            case generationIv = "generation-iv"
            case generationV = "generation-v"
            case generationVi = "generation-vi"
            case generationVii = "generation-vii"
            case generationViii = "generation-viii"
        }
    }
    
    // MARK: - Sprites
    class Sprites: Codable {
        let backDefault, backFemale, backShiny, backShinyFemale: String?
        let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
        let other: Other?
        let versions: Versions?
        let animated: Sprites?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backFemale = "back_female"
            case backShiny = "back_shiny"
            case backShinyFemale = "back_shiny_female"
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
            case other, versions, animated
        }
        
        init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: Sprites?) {
            self.backDefault = backDefault
            self.backFemale = backFemale
            self.backShiny = backShiny
            self.backShinyFemale = backShinyFemale
            self.frontDefault = frontDefault
            self.frontFemale = frontFemale
            self.frontShiny = frontShiny
            self.frontShinyFemale = frontShinyFemale
            self.other = other
            self.versions = versions
            self.animated = animated
        }
    }
    
    // MARK: - GenerationI
    struct GenerationI: Codable {
        let redBlue, yellow: RedBlue?
        
        enum CodingKeys: String, CodingKey {
            case redBlue = "red-blue"
            case yellow
        }
    }
    
    // MARK: - RedBlue
    struct RedBlue: Codable {
        let backDefault, backGray, backTransparent, frontDefault: String?
        let frontGray, frontTransparent: String?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backGray = "back_gray"
            case backTransparent = "back_transparent"
            case frontDefault = "front_default"
            case frontGray = "front_gray"
            case frontTransparent = "front_transparent"
        }
    }
    
    // MARK: - GenerationIi
    struct GenerationIi: Codable {
        let crystal: Crystal?
        let gold, silver: Gold?
    }
    
    // MARK: - Crystal
    struct Crystal: Codable {
        let backDefault, backShiny, backShinyTransparent, backTransparent: String?
        let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case backShinyTransparent = "back_shiny_transparent"
            case backTransparent = "back_transparent"
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case frontShinyTransparent = "front_shiny_transparent"
            case frontTransparent = "front_transparent"
        }
    }
    
    // MARK: - Gold
    struct Gold: Codable {
        let backDefault, backShiny, frontDefault, frontShiny: String?
        let frontTransparent: String?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case frontTransparent = "front_transparent"
        }
    }
    
    // MARK: - GenerationIii
    struct GenerationIii: Codable {
        let emerald: OfficialArtwork?
        let fireredLeafgreen, rubySapphire: Gold?
        
        enum CodingKeys: String, CodingKey {
            case emerald
            case fireredLeafgreen = "firered-leafgreen"
            case rubySapphire = "ruby-sapphire"
        }
    }
    
    // MARK: - OfficialArtwork
    struct OfficialArtwork: Codable {
        let frontDefault, frontShiny: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
        }
    }
    
    // MARK: - Home
    struct Home: Codable {
        let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
        }
    }
    
    // MARK: - GenerationVii
    struct GenerationVii: Codable {
        let icons: DreamWorld?
        let ultraSunUltraMoon: Home?
        
        enum CodingKeys: String, CodingKey {
            case icons
            case ultraSunUltraMoon = "ultra-sun-ultra-moon"
        }
    }
    
    // MARK: - DreamWorld
    struct DreamWorld: Codable {
        let frontDefault: String?
        let frontFemale: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontFemale = "front_female"
        }
    }
    
    // MARK: - GenerationViii
    struct GenerationViii: Codable {
        let icons: DreamWorld?
    }
    
    // MARK: - Other
    struct Other: Codable {
        let dreamWorld: DreamWorld?
        let home: Home?
        let officialArtwork: OfficialArtwork?
        
        enum CodingKeys: String, CodingKey {
            case dreamWorld = "dream_world"
            case home
            case officialArtwork = "official-artwork"
        }
    }
    
    // MARK: - Stat
    struct Stat: Codable {
        let baseStat, effort: Int?
        let stat: Species?
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort, stat
        }
    }
    
    // MARK: - TypeElement
    struct TypeElement: Codable {
        let slot: Int?
        let type: Species?
        
        enum CodingKeys: String, CodingKey {
            case slot
            case type = "type"
        }
    }
    
    // MARK: - HeldItem
    struct HeldItem: Codable {
        let item: Species?
        let versionDetails: [VersionDetail]?
        
        enum CodingKeys: String, CodingKey {
            case item
            case versionDetails = "version_details"
        }
    }
    
    struct VersionDetail: Codable {
        let rarity: Int?
        let version: Species?
    }
    
    // MARK: - PastType
    struct PastType: Codable {
        let generation: Species?
        let types: [Species]?
    }
    
    
    func getPokemonImageOriginal() -> String {
        guard let id = self.id else { return ""}
        let pathUrl = String(format: "%03d", id)
        return "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/\(pathUrl).png"
    }
}


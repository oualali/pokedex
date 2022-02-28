//
//  Api.swift
//  Pokidex
//
//  Created by IMAC22 on 20/01/2022.
//

import Foundation

struct Response : Codable{
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Pokemons]
    
}
struct Pokemons: Codable{
    var name: String?
    var url: String?
    
    func getPicUrl() -> String {
        let format = ".png"
        let urlSplit = url!.components(separatedBy: "/")
        let id = urlSplit[urlSplit.count - 2]
        let base = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
        
        //var base_svg = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/"
        //let format_svg = ".svg"
        
        return "\(base)\(id)\(format)"
    }
    
}

extension Pokemons {
    
    mutating func setFr(fr: String!) {
        name = fr
    }
}
/*
struct PokemonSpecies: Codable {
    var baseHappiness, captureRate: Int?
    var color: Color?
    var eggGroups: [Color]?
    var evolutionChain: EvolutionChain?
    var evolvesFromSpecies: Color?
    var flavorTextEntries: [FlavorTextEntry]?
    var formDescriptions: [Any?]?
    var formsSwitchable: Bool?
    var genderRate: Int?
    var genera: [Genus]?
    var generation, growthRate, habitat: Color?
    var hasGenderDifferences: Bool?
    var hatchCounter, id: Int?
    var isBaby, isLegendary, isMythical: Bool?
    var name: String?
    var names: [Name]?
    var order: Int?
    var palParkEncounters: [PalParkEncounter]?
    var pokedexNumbers: [PokedexNumber]?
    var shape: Color?
    var varieties: [Variety]?
}

// MARK: - Color
struct Color: Codable {
    var name: String
    var url: String
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    var url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    var flavorText: String
    var language, version: Color
}

// MARK: - Genus
struct Genus: Codable {
    var genus: String
    var language: Color
}

// MARK: - Name
struct Name : Codable{
    var language: Color
    var name: String
}

// MARK: - PalParkEncounter
struct PalParkEncounter: Codable {
    var area: Color
    var baseScore, rate: Int
}

// MARK: - PokedexNumber
struct PokedexNumber: Codable {
    var entryNumber: Int
    var pokedex: Color
}

// MARK: - Variety
struct Variety : Codable {
    var isDefault: Bool
    var pokemon: Color
}
*/

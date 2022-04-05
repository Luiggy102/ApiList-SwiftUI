//
//  ViewModel.swift
//  PokemonList
//
//  Created by LMCM on 4/5/22.
//

import Foundation

// Json struct

// {
//  "count": 1118,
//  "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
//  "previous": null,
//  "results": [
//    {
//      "name": "bulbasaur",
//      "url": "https://pokeapi.co/api/v2/pokemon/1/"
//    },
//    {
//      "name": "ivysaur",
//      "url": "https://pokeapi.co/api/v2/pokemon/2/"
//    },
//    ...
// }

struct PokemonDataModel: Decodable { let name, url: String }

struct PokemonResponseDataModel: Decodable {
    let pokemons: [PokemonDataModel]
    // Only put the case that we want to recive
    enum CodingKeys: String, CodingKey {
    case results
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
    }
}

final class ViewModel {
    func getPokemons() {
        let apiUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151")
        let urlSession = URLSession.shared
        urlSession.dataTask(with: apiUrl!) { data, _, error in
            guard let data = data, error == nil else { return }
            print("Got Data: \(data)")
            let pokemonDataModel = try? JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
            guard let pokemonDataModel = pokemonDataModel else { return }
            print(pokemonDataModel)
        }.resume()
    }
}

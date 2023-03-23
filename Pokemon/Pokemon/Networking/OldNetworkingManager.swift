//
//  OldNetworkingManager.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 28/2/23.
//

import UIKit
import Alamofire

final class OldNetworkingManager {
    static let shared: OldNetworkingManager = OldNetworkingManager()

    private let baseUrl = "https://pokeapi.co/api/v2/"

    func fetchFirst151Pokemon(comp: @escaping (Pokedex) -> Void) {
        let endpoint: String = "pokemon?limit=151&offset=0"
        guard let url = URL(string: baseUrl + endpoint) else { return }

        let task = AF.request(url)
        task.responseDecodable(of: Pokedex.self) { response in
            switch response.result {
            case .success(let pokedex):
                comp(pokedex)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        task.resume()
    }

    func fetchPokemonWithURL(url: String, comp: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: url) else { return }

        let task = AF.request(url)
        task.responseDecodable(of: Pokemon.self) { response in
            switch response.result {
            case .success(let jsonData):
                comp(jsonData)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        task.resume()
    }

    func fetchPokemonImage(pokemon: PokedexEntries, completion: @escaping (UIImage?) -> Void) {
        guard let pokemonID = pokemon.pokemonID else {
            return
        }
        guard let imageURL =
                URL(string:
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonID).png")
        else {
            return
        }

        let task = AF.request(imageURL, method: .get)
        task.responseData { response in
            switch response.result {
            case .success(let data):
                let imageData = UIImage(data: data)
                completion(imageData)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}

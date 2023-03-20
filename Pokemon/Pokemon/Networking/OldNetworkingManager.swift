//
//  OldNetworkingManager.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 28/2/23.
//

import UIKit

final class OldNetworkingManager {
    static let shared: OldNetworkingManager = OldNetworkingManager()

    private let baseUrl = "https://pokeapi.co/api/v2/"
    func fetchFirst151Pokemon(comp: @escaping (Pokedex) -> Void) {
        let endpoint: String = "pokemon?limit=151&offset=0"
        guard let url = URL(string: baseUrl + endpoint) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return print(error)
            } else if let data = data {
                do {
                    let json = try JSONDecoder().decode(Pokedex.self, from: data)
                    comp(json)
                } catch {
                    print("Error occured during parsing", error)
                }
            } else if let response = response {
                print("Response: \(response)")
                return
            }
        }
        task.resume()
    }

    func fetchPokemonWithURL(url: String, comp: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return print(error)
            } else if let data = data {
                do {
                    let json = try JSONDecoder().decode(Pokemon.self, from: data)
                    comp(json)
                } catch {
                    print("Error occured during parsing", error)
                }
            } else if let response = response {
                print("Response: \(response)")
                return
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

        let request = URLRequest(url: imageURL)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return print("Error from network manager: \(error)")
            } else if let data = data {
                let imageData = UIImage(data: data)
                completion(imageData)
            } else if let response = response {
                return print("Response: \(response)")
            }
        }
        task.resume()
    }
}

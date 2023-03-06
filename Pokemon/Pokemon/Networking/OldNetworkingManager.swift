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
    func fetchFirst151Pokemon(comp: @escaping (Pokedex)-> ()) {
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
            } else {
                return
            }
        }
        task.resume()
    }
    
    func fetchPokemonWithURL(url: String, comp: @escaping (Pokemon)-> ()) {
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
            } else {
                return
            }
        }
        task.resume()
    }
    
//    func fetchPokemonImage(url: URL) -> UIImage? {
//        let imageData = try! Data(contentsOf: url)
//        if let image = UIImage(data: imageData) {
//            return image
//        }
//        return nil
//    }
    
}

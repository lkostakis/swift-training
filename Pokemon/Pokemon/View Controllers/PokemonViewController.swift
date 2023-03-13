//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 1/3/23.
//

import UIKit

class PokemonViewController: UIViewController {
    private var pokemon: Pokemon?
    private let network = OldNetworkingManager()
    private let pokemonURL: String?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 600
        tableView.contentInsetAdjustmentBehavior = .automatic
        initPokemon()
    }

    init?(coder: NSCoder, pokemonURL: String) {
        self.pokemonURL = pokemonURL
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPokemon() {
        guard let pokemonURL = self.pokemonURL else {
            return
        }

        network.fetchPokemonWithURL(url: pokemonURL, comp: { data in
            self.pokemon = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemon = pokemon, let pokemonName = pokemon.name, let baseStat = pokemon.stats?[indexPath.row].baseStat,
              let typeName = pokemon.types?[indexPath.row].type?["name"] else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }

        cell.configure(name: pokemonName, baseStat: baseStat, type: typeName)
        return cell
    }
}

extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

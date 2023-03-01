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
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        self.tableView.contentInsetAdjustmentBehavior = .automatic
        network.fetchPokemonWithURL(url: pokemonURL!, comp: { data in
            self.pokemon = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    init?(coder: NSCoder, pokemonURL: String) {
        self.pokemonURL = pokemonURL
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemon = pokemon else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell else {
            fatalError("error")
        }
        cell.backgroundColor = .systemGray6
        return cell.configure(name: pokemon.name ?? "", baseStat: self.pokemon?.stats?[indexPath.row].baseStat ?? 0, type: pokemon.types?[indexPath.row].type?["name"]! ?? "")
    }
    
    
}

extension PokemonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

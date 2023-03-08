//
//  ViewController.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 28/2/23.
//

import UIKit

class ViewController: UIViewController {

    private let network = OldNetworkingManager()
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private var pokedex: Pokedex?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemGray5
        title = "Pokedex"
        tableView.estimatedRowHeight = 600
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        network.fetchFirst151Pokemon { data in
            self.pokedex = data
            Writer.shared.writeToMemory(pokedex: self.pokedex)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideLoading()
            }
        }
    }

    @IBSegueAction func showPokemonDetails(_ coder: NSCoder) -> PokemonViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Nothing selected!")
        }
        let pokemon = self.pokedex?.results?[indexPath.row]
        return PokemonViewController(coder: coder, pokemonURL: pokemon?.url ?? "")
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pokedex?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokedex = self.pokedex else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath) as? PokedexCell else {
            return UITableViewCell()
        }
        guard let pokemon = pokedex.results?[indexPath.row], let pokemonName = pokemon.name, let pokemonURL = pokemon.url else {
            return UITableViewCell()
        }

        network.fetchPokemonImage(pokemon: pokemon, completion: { image in
            if let image = image {
                DispatchQueue.main.async {
                    if pokemonURL == cell.URLLabel.text {
                        return cell.configure(name: pokemonName, url: pokemonURL, image: image)
                    }
                }
            }
        })

        cell.configure(name: pokemonName, url: pokemonURL)
        return cell
    }
}

extension ViewController {
    func hideLoading() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.isHidden = true
        self.networkLabel.isHidden = true
    }

    func showLoading() {
        loadingIndicator.startAnimating()
        networkLabel.text = "Waiting for internet connection..."
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

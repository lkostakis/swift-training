//
//  ViewController.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 28/2/23.
//

import UIKit

class ViewController: UIViewController {

    let network = OldNetworkingManager()
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var pokedex: Pokedex?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        networkLabel.text = "Waiting for internet connection..."
        navigationController?.navigationBar.backgroundColor = .systemGray5
        title = "Pokedex"
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.contentInsetAdjustmentBehavior = .automatic
        
        self.network.fetchFirst151Pokemon { data in
            self.pokedex = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            // Writer.shared.writeToMemory()
        }
//        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
//        }
    }

    @IBSegueAction func showPokemonDetails(_ coder: NSCoder) -> PokemonViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Nothing selected!")
        }
        let pokemon = pokedex?.results?[indexPath.row]
        return PokemonViewController(coder: coder, pokemonURL: pokemon?.url ?? "")
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokedex?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokedex = pokedex else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath) as? PokedexCell else {
            fatalError("error")
        }
        
        loadingIndicator.startAnimating()
        let imageURL = URL(string:
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"+"\(pokedex.results![indexPath.row].pokemonID)"+".png")
        
        network.fetchPokemonImage(imageURL: imageURL!, completion: { data in
            if let data = data {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                    self.networkLabel.isHidden = true
                    cell.configure(name: pokedex.results?[indexPath.row].name ?? "", url: pokedex.results?[indexPath.row].url ?? "", image: data)
                }
            } else {
                cell.configure(name: pokedex.results?[indexPath.row].name ?? "", url: pokedex.results?[indexPath.row].url ?? "")
            }
        })
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

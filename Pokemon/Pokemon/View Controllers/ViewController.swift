//
//  ViewController.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 28/2/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loaderIndicator: UITableView!
    let network = OldNetworkingManager()
    @IBOutlet weak var tableView: UITableView!
    var pokedex: Pokedex?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .systemGray5
        title = "Pokedex"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        self.tableView.contentInsetAdjustmentBehavior = .automatic
        network.fetchFirst151Pokemon { data in
            self.pokedex = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        
        let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"+"\(pokedex.results![indexPath.row].pokemonID)"+".png")!
        
        DispatchQueue.global().async {
            let imageData = try! Data(contentsOf: imageURL)
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    cell.configure(name: pokedex.results?[indexPath.row].name ?? "", url: pokedex.results?[indexPath.row].url ?? "", image: image)
                }
            } else {
                cell.configure(name: pokedex.results?[indexPath.row].name ?? "", url: pokedex.results?[indexPath.row].url ?? "")
            }
        }
        return cell

    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

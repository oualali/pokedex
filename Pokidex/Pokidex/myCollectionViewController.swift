//
//  myCollectionViewController.swift
//  Pokidex
//
//  Created by IMAC28 on 19/01/2022.
//

import UIKit

class Obj {
    let nom:String!
    let url:String!
    
    init(_nom: String!, _url:String!) {
        self.nom = _nom
        self.url = _url
    }
}


class myCollectionViewController: UICollectionViewController {
    
    var data = [Pokemons]()
    var nomFr = [String]()
    var selectedPokemon: Pokemons!
    
    override func viewDidLoad() {
        self.fetch{
            result in
            self.data = result.results
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getPokemonNameFr(namePokemon: String,_ completion: @escaping(String) -> Void ) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(namePokemon)")

        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            /*
            let pokemonSpecies = try! JSONDecoder().decode(PokemonSpecies.self, from: data)
            print(pokemonSpecies.names)
            
            /*let pokemonFr = pokemonSpecies.names.filter {$0.language.name == "fr"}
            if let namePokemonFr = pokemonFr.first {
                completion(namePokemonFr.name)
            }
            else {
                completion(namePokemon)
            }*/*/
            completion("test")
        }.resume()
    }
    
    
    func fetch(_ completion: @escaping(Response) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=200")

        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }

            let json = try! JSONDecoder().decode(Response.self, from: data)
            completion(json)
           
        }
        task.resume()

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedPokemon = data[indexPath.row]
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        var cell = UICollectionViewCell()
        let curr_obj = data[indexPath.row]
        var nom = curr_obj.name
        /*
        self.getPokemonNameFr(namePokemon: curr_obj.name!) {
            result in
            nom = result
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }*/
        
        
        
        if let objCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? myCollectionViewCell {
            
            objCell.setCell(with: curr_obj.name, with: curr_obj.getPicUrl())
            cell = objCell
        }
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("O \(selectedName)")
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //print("1 \(selectedName)")
        if segue.identifier == "detail" {
            if let viewController =
                segue.destination as? ViewController {
                print("v")
                viewController.nom = selectedPokemon.name
            }
            if let tabBar =
                segue.destination as? myTabBarController {
                print("t_bar")
                tabBar.pokemon = selectedPokemon
            }
        }
     }
     //
}

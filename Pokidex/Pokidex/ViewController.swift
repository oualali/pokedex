//
//  ViewController.swift
//  Pokidex
//
//  Created by IMAC28 on 19/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var p_nom: UILabel!
    
    var nom: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //p_nom.text = nom
        // Do any additional setup after loading the view.
    }
}

class PowerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var v_nom: UILabel!
    @IBOutlet weak var v_url: UIImageView!
    @IBOutlet weak var tab_powers: UITableView!
    var powers: [Ability]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tab_powers.delegate = self
        self.tab_powers.dataSource = self
        
        let tabBar = tabBarController as! myTabBarController
        v_nom.text = tabBar.pokemon.name
        setImage(from: tabBar.pokemon.getPicUrl())
        
        self.fetch(_url: tabBar.pokemon.url!){
            result in
            self.powers = result
            DispatchQueue.main.async {
                self.tab_powers.reloadData()
            }
        }
    
        //p_nom.text = nom
        // Do any additional setup after loading the view.
    }
    
    func fetch(_url:String, _ completion: @escaping([Ability]) -> Void) {
        let url = URL(string: "\(_url)")

        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            do {
                let json = try JSONDecoder().decode(InfoPokemon.self, from: data)
                completion(json.abilities!)
            } catch let error {
                print(error.localizedDescription)
            }
           
        }
        task.resume()

    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let img = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.v_url.image = img
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return powers == nil ? 1 : powers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if powers != nil {
            let frameLabel = CGRect(x: 8, y: 4, width: 200, height: 46)
            let label = UILabel(frame: frameLabel)
            label.text = powers![indexPath.row].ability?.name!
            cell.addSubview(label)
        }
        return cell
    }
}

class OtherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var a_nom: UILabel!
    @IBOutlet weak var a_url: UIImageView!
    
    @IBOutlet weak var tab_move: UITableView!
    var moves: [Move]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = tabBarController as! myTabBarController
        //moves = tabBar.pokeMoves
        a_nom.text = tabBar.pokemon.name
        setImage(from: tabBar.pokemon.getPicUrl())
        //p_nom.text = nom
        // Do any additional setup after loading the view.
        self.tab_move.delegate = self
        self.tab_move.dataSource = self
        
        
        self.fetch(_url: tabBar.pokemon.url!){
            result in
            self.moves = result
            //print("Abilities \(self.pokeMoves.count)" )
            DispatchQueue.main.async {
                self.tab_move.reloadData()
            }
        }
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let img = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.a_url.image = img
            }
        }
    }
    func fetch(_url:String, _ completion: @escaping([Move]) -> Void) {
        let url = URL(string: "\(_url)")

        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            do {
                let json = try JSONDecoder().decode(InfoPokemon.self, from: data)
                completion(json.moves!)
            } catch let error {
                print(error.localizedDescription)
            }
           
        }
        task.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moves == nil ? 1 : moves!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if moves != nil {
            let frameLabel = CGRect(x: 8, y: 4, width: 200, height: 46)
            let label = UILabel(frame: frameLabel)
            label.text = moves![indexPath.row].move?.name!
            //print(label.text!)
            cell.addSubview(label)
        }
        return cell
    }
}


class LauncherController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = traitCollection.userInterfaceStyle == .light ? UIImage(named: "logo_white") : UIImage(named: "logo_black")
    }
}

//UIImage(named: "green-square-Retina")

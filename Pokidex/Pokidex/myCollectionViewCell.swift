//
//  myCollectionViewCell.swift
//  Pokidex
//
//  Created by IMAC28 on 19/01/2022.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nom: UILabel!
    
    func setCell(with label: String!, with url: String!) {
        nom.text = label
        setImage(from: url)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let img = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.photo.image = img
            }
        }
    }
}

//
//  myTableView.swift
//  Pokidex
//
//  Created by IMAC20 on 21/01/2022.
//

import UIKit

class myTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        let cell = UITableViewCell()
        let frameLabel = CGRect(x: 8, y: 4, width: 200, height: 46)
        let label = UILabel(frame: frameLabel)
        //label.text = names[indexPath.row]
        cell.addSubview(label)

        return cell
    }
}

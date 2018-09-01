//
//  TableViewCell.swift
//  TraineeTestProject
//
//  Created by Maksym on 8/30/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    func tableViewCell(shareButtonTap tableViewCell: UITableViewCell)
}

class TableViewCell: UITableViewCell {

    var delegate: TableViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    @IBAction func onShare(_ sender: Any) {
        self.delegate?.tableViewCell(shareButtonTap: self)
    }
    
    func initializate(nameLabel: String, img: UIImage) {
        self.nameLabel.text = nameLabel
        self.photoView.image = img
    }
}

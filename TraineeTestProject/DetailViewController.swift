//
//  DetailViewController.swift
//  TraineeTestProject
//
//  Created by Vlad Demchenko on 29.08.2018.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    var allData: PrivatData?
    var logoName: String?
    
    @IBOutlet weak var logoOfCurrency: UIImageView!
    @IBOutlet weak var infoAboutCurrency: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "\(allData?.ccy ?? "z")"
        logoOfCurrency.image = UIImage(named: logoName ?? "")
        
        infoAboutCurrency.text = "Buy: 1 \(allData?.ccy ?? "") = \(allData?.buy ?? "") \(allData?.base_ccy ?? "")\nSale: 1 \(allData?.ccy ?? "") = \(allData?.sale ?? "") \(allData?.base_ccy ?? "")"
        
        // Do any additional setup after loading the view.
    }

    class func create(allData: PrivatData, logoOfCurrency: String) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        vc.allData = allData
        vc.logoName = logoOfCurrency
        
        return vc
    }

}

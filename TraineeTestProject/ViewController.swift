//
//  ViewController.swift
//  TraineeTestProject
//
//  Created by Vlad Demchenko on 28.08.2018.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import UIKit
import Alamofire

struct PrivatData: Decodable{
    let ccy: String
    let base_ccy: String
    let buy: String
    let sale: String
    
    init (ccy: String, base_ccy: String, buy: String, sale: String){
        self.ccy = ccy
        self.base_ccy = base_ccy
        self.buy = buy
        self.sale = sale
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let defaults = UserDefaults.standard
    
    let url = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    
    var allData: [PrivatData] = []
    var currencyImage: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        let decoder = JSONDecoder()
        
        Alamofire.request(url).responseJSON {
            response in
            guard let json = response.data else { return }
            do {
                self.allData = try decoder.decode([PrivatData].self, from: json)
                self.tableView.reloadData()
            } catch let err {
                print(err)
                return
            }
        }
    }
    
    func saveData(){
        self.defaults.set(self.allData, forKey: "saveXuy")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch allData[indexPath.row].ccy {
        case "USD":
            currencyImage = "usd"
        case "EUR":
            currencyImage = "eur"
        case "RUR":
            currencyImage = "rur"
        case "BTC":
            currencyImage = "bitcoin"
        default:
            currencyImage = ""
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self)) as! TableViewCell
        cell.initializate(nameLabel: self.allData[indexPath.row].ccy, img: UIImage(named: currencyImage ?? "")!)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.show(DetailViewController.create(allData: self.allData[indexPath.row], logoOfCurrency:  currencyImage ?? ""), sender: self)
    }
}

extension ViewController: TableViewCellDelegate {
    func tableViewCell(shareButtonTap tableViewCell: UITableViewCell) {
        let indexPath = tableView.indexPath(for: tableViewCell)
        
        let activityVC = UIActivityViewController(activityItems: ["Currency of \(self.allData[indexPath?.row ?? 0].base_ccy) to \(self.allData[indexPath?.row ?? 0].ccy): buy = \(self.allData[indexPath?.row ?? 0].buy), sale = \(self.allData[indexPath?.row ?? 0].sale)."], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
   
}

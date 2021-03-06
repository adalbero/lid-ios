//
//  SettingViewController.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 16.06.22.
//

import UIKit

protocol SetBundeslandDelegate {
    func setBundesland(bundesland: String)
}

class SettingViewController: UIViewController {
    
    var delegate: SetBundeslandDelegate?

    let bundeslaender = ["Brandenburg", "Berlin", "Baden-Württemberg", "Bayern", "Bremen", "Hessen", "Hamburg", "Mecklenburg-Vorpommern", "Niedersachsen", "Nordrhein-Westfalen", "Rheinland-Pfalz", "Schleswig-Holstein", "Saarland", "Sachsen", "Sachsen-Anhalt", "Thüringen"]

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    // MARK: - Navigation
}

//functionality of each Cell
extension SettingViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        delegate?.setBundesland(bundesland: bundeslaender[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
//apperance of each cell?
extension SettingViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bundeslaender.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        
        cell.textLabel?.text = bundeslaender[indexPath.row]
        
        
        
        return cell
    }
}

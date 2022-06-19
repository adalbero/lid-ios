//
//  SecondViewController.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 09.06.22.
//

import UIKit

class SecondViewController: UIViewController {
    var questions = loadCSV(from: "question_list")
    var userBundesland: String = "Niedersachsen"
    var groupBundesland: [Questions] = []
    
    var questionGroups: [QuestionHolder] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        title = "Second Screen"
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //groupBundesland = groupFilter(array_to_filter: questions, key: "Niedersachsen", atribute: "theme")
        questionGroups = createGroups(array: questions, bundesland: userBundesland)
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func didTapSetting(_ sender: Any) {
        print(userBundesland)
        let vc = storyboard?.instantiateViewController(identifier: "setting") as! SettingViewController
        //vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        
    }
    func createGroups(array: [Questions], bundesland: String) -> [QuestionHolder]{
        var returnHolder = [QuestionHolder]()
        
        var temp: [String] = groupFilterBundesland(selected_Bundesland: bundesland)
        
        for questionSlot in array{
            
            if !temp.contains(questionSlot.theme) {
                temp.append(questionSlot.theme)
                returnHolder.append(QuestionHolder.init(questions_to_hold: [questionSlot], header: questionSlot.theme, comment: questionSlot.area))
            }else{
                
                for i in returnHolder.indices {
                    if returnHolder[i].header == questionSlot.theme{
                        returnHolder[i].addQuestion(question_to_add: questionSlot)
                    }
                }
            }
        }
        
        //debug
        
        for holder in returnHolder {
            print(holder.header + " - " ,holder.getSize())
        }
        return returnHolder
    }
    
    
    func groupFilterBundesland(selected_Bundesland: String) -> [String]{
        var allBundesland = ["Brandenburg", "Berlin", "Baden-Württemberg", "Bayern", "Bremen", "Hessen", "Hamburg", "Mecklenburg-Vorpommern", "Niedersachsen", "Nordrhein-Westfalen", "Rheinland-Pfalz", "Schleswig-Holstein", "Saarland", "Sachsen", "Sachsen-Anhalt", "Thüringen"]
        for i in allBundesland.indices{
            if allBundesland[i] == selected_Bundesland{
                allBundesland.remove(at: i)
                break
            }
        }
        return allBundesland
    }
    
    
   /* func groupFilter(array_to_filter: [Questions], key: String, atribute: String) -> [Questions]{
        let unfiltedArray = array_to_filter
        var filtedArray = [Questions]()
        
        if atribute.lowercased() == "tags"{
            
            for rawQuestion in unfiltedArray {
                if rawQuestion.tags == key{     //fix String == String
                    filtedArray.append(rawQuestion)
                }
            }
        } else if atribute.lowercased() == "theme" {
            for rawQuestion in unfiltedArray {
                if rawQuestion.theme == key{     //fix String == String
                    filtedArray.append(rawQuestion)
                }
            }
        } else if atribute.lowercased() == "area" {
            for rawQuestion in unfiltedArray {
                if rawQuestion.area == key{     //fix String == String
                    filtedArray.append(rawQuestion)
                }
            }
        } else if atribute.lowercased() == "area_code" {
            for rawQuestion in unfiltedArray {
                if rawQuestion.area_code == key{     //fix String == String
                    filtedArray.append(rawQuestion)
                }
            }
        }
        
        return filtedArray
    }*/
    
}

extension SecondViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SecondViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTest", for: indexPath)
        
        cell.textLabel?.text = questionGroups[indexPath.row].header
        
        
        
        return cell
    }
}

extension SecondViewController: SetBundeslandDelegate {
    
    func setBundesland(bundesland: String) {
        self.dismiss(animated: true){ [self] in
            self.userBundesland = bundesland
            questionGroups = self.createGroups(array: self.questions, bundesland: self.userBundesland)
            self.tableView.reloadData()
        }
    }
}

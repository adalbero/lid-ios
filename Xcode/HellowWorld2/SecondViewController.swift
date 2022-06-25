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
    
    var questionGroups: [[QuestionHolder]] = [[]]
    
    var sectionNames: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        title = "Second Screen"
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func createGroups(array: [Questions], bundesland: String) -> [[QuestionHolder]]{
        var returnHolder = [[QuestionHolder]()]
        var topicHolder = [QuestionHolder]()
        var themeHolder = [QuestionHolder]()
        var genericHolder = [QuestionHolder]()
        
        var tempTopic: [String] = groupFilterBundesland(selected_Bundesland: bundesland)
        var tempTheme: [String] = ["Bundesland"]
        
        sectionNames.append("Questions")
        sectionNames.append("Themes")
        sectionNames.append("Topic")
        
        
        for questionSlot in array{
            
            //topicHolder Generation
            if !tempTopic.contains(questionSlot.theme) {
                tempTopic.append(questionSlot.theme)
                topicHolder.append(QuestionHolder.init(questions_to_hold: [questionSlot], header: questionSlot.theme, comment: questionSlot.area))
            }else{
                
                for i in topicHolder.indices {
                    if topicHolder[i].header == questionSlot.theme{
                        topicHolder[i].addQuestion(question_to_add: questionSlot)
                    }
                }
            }
            
            //themeHolder Generation
            if !tempTheme.contains(questionSlot.area) {
                tempTheme.append(questionSlot.area)
                themeHolder.append(QuestionHolder.init(questions_to_hold: [questionSlot], header: questionSlot.area, comment: "by Theme"))
            }else{
                
                for i in themeHolder.indices {
                    if themeHolder[i].header == questionSlot.area{
                        themeHolder[i].addQuestion(question_to_add: questionSlot)
                    }
                }
            }
            
            //genericHolder Generation
            if genericHolder.isEmpty{
                genericHolder.append(QuestionHolder(questions_to_hold: [questionSlot], header: "Alle", comment: "All general Questions"))
            }
                
        }
        
        genericHolder.append(topicHolder.removeLast())
        returnHolder.append(genericHolder)
        returnHolder.append(themeHolder.sorted(by: {$0.header > $1.header}))
        returnHolder.append(topicHolder.sorted(by: {$0.comment > $1.comment}))

 
        return returnHolder//sorted(by: {$0.comment > $1.comment})
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
}

// MARK: - extentions (tableView)

extension SecondViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

extension SecondViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionGroups.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTest", for: indexPath)
        if questionGroups[indexPath.section][indexPath.row].comment == "Politik in der Demokratie" {
            cell.backgroundColor = UIColor(red: 0.98, green: 0.87, blue: 0.56, alpha: 1.00)
        } else if questionGroups[indexPath.section][indexPath.row].comment == "Geschichte und Verantwortung" {
            cell.backgroundColor = UIColor(red: 0.50, green: 0.84, blue: 0.98, alpha: 1.00)
        } else if questionGroups[indexPath.section][indexPath.row].comment == "Mensch und Gesellschaft" {
            cell.backgroundColor = UIColor(red: 0.76, green: 0.88, blue: 0.64, alpha: 1.00)
        } else if questionGroups[indexPath.section][indexPath.row].header == "Politik in der Demokratie" {
            cell.backgroundColor = UIColor(red: 0.98, green: 0.87, blue: 0.56, alpha: 1.00)
        } else if questionGroups[indexPath.section][indexPath.row].header == "Geschichte und Verantwortung" {
            cell.backgroundColor = UIColor(red: 0.50, green: 0.84, blue: 0.98, alpha: 1.00)
        } else if questionGroups[indexPath.section][indexPath.row].header == "Mensch und Gesellschaft" {
            cell.backgroundColor = UIColor(red: 0.76, green: 0.88, blue: 0.64, alpha: 1.00)
        } else {
            cell.backgroundColor = .white
        }
        
        cell.textLabel?.text = questionGroups[indexPath.section][indexPath.row].header + " (" + String(questionGroups[indexPath.section][indexPath.row].getSize()) + ")"
        
        
        
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
